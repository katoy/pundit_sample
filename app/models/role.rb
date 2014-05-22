class Role < ActiveRecord::Base
  has_one :user
  has_many :roles_abilities, :dependent => :destroy
  has_many :abilities, through: :roles_abilities
  accepts_nested_attributes_for :roles_abilities, :update_only => true

  validates_presence_of :name

  #
  # role新規作成時にabilityのチェックが0件だったらエラー
  #
  validates_each :ability do |record, attr, value|
    if record.roles_abilities.blank?
      record.errors.add attr, '権限は1件以上選択してください'
    end
  end

  def ability
    Ability.ability_hash_with_id self.roles_abilities.map(&:ability_id)
  end

  def ability_id_to_a
    roles_abilities.map(&:ability_id)
  end

  def index_by_ability_id
    roles_abilities.index_by(&:ability_id)
  end

  #
  # roleに紐づくability_idを更新する際、
  #   * 不要になるroles_abilities.ability_idが存在したら物理削除
  #   * 新しく作成するものは新規作成
  #   * 既にあるものは何もしない
  #
  def destroy_and_update(params)
    ActiveRecord::Base.transaction do
      destroy_old_abilities(params)
      self.attributes = push_current_roles_abilities_id(params)
      raise ActiveRecord::Rollback unless self.save
      reload
      true
    end
  rescue => e
    logger.error e.message
    e.backtrace.each { |line| logger.error line }
    false
  end

  #
  # paramsのability_idに現在のability_idが入っていた場合、
  # hashにroles_abilities.idを追加する
  #
  # 更新時のリクエストパラメータもability_idのみだが、
  # 既に存在するability_idが入ってるレコードには何もしたくない。
  # そのため、updateを呼ぶ際にroles_abilities.idを追加する。
  #
  def push_current_roles_abilities_id(params)
    params["roles_abilities_attributes"].each do |item|
      if index_by_ability_id.include? item["ability_id"].to_i
        item["id"] = index_by_ability_id[item["ability_id"].to_i].id.to_s
      end
    end

    params
  end

  #
  # 削除するability_idがインスタンスのroles_abilities.ability_idと
  # 一致していたら物理削除
  #
  def destroy_old_abilities(params)
    destroy_id = get_destroy_id(params)

    unless destroy_id.blank?
      RolesAbility.where(role_id: id).where(ability_id: destroy_id).delete_all
    end
  end

  #
  # role更新時に削除するability_idを取得して配列で返す
  #
  # privateメソッドでもいいような気がするが、
  # 正しく削除するidを取得してるかテストしたかった
  #
  def get_destroy_id(params)
    ability_id_to_a - params_to_array(params)
  end

  scope :except_admin, -> {
    select(:id, :name).joins(:roles_abilities).joins(:abilities).where.not(abilities: { domain: "admin" }).uniq
  }

  private

  #
  # パラメータで渡されたability_idを配列で返す
  #
  def params_to_array(params)
    raise ArgumentError unless params.include?("roles_abilities_attributes")
    params["roles_abilities_attributes"].map{ |item| item["ability_id"].to_i }
  rescue ArgumentError
    errors.add "Ability", "権限は1件以上選択してください"
    raise ActiveRecord::Rollback
  end
end
