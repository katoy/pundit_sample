class User < ActiveRecord::Base
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
  belongs_to :role

  validates :name,  presence: true
  validates :email, presence: true
  validates :password, confirmation: true

  def ability
    Ability.ability_hash role.roles_abilities.map(&:ability_id)
  end

  def admin?
    ability.include? 'admin'
  end

  scope :except_admin, -> { joins(:role).where.not(roles: { name: 'administrator' }) }
end
