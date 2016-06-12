require 'spec_helper'

describe UserPolicy do
  subject { UserPolicy }

  permissions :index? do
    context '管理者' do
      include_context '管理者'
      it { is_expected.to permit(user, User.new) }
    end

    context '権限保持者' do
      include_context 'User'
      it { is_expected.to permit(user, User.new) }
    end

    context '権限非保持者' do
      include_context 'Role'
      it { is_expected.not_to permit(user, User.new) }
    end
  end

  permissions :show? do
    context '管理者' do
      include_context '管理者'
      it { is_expected.to permit(user, User.new) }
    end

    context '権限保持者' do
      include_context 'User'
      it { is_expected.to permit(user, User.new) }
    end

    context '権限非保持者' do
      include_context 'Role'
      it { is_expected.not_to permit(user, User.new) }
    end
  end

  permissions :new? do
    context '管理者' do
      include_context '管理者'
      it { is_expected.to permit(user, User.new) }
    end

    context '権限保持者' do
      include_context 'User'
      it { is_expected.to permit(user, User.new) }
    end

    context '権限非保持者' do
      include_context 'Role'
      it { is_expected.not_to permit(user, User.new) }
    end
  end

  permissions :create? do
    context '管理者' do
      include_context '管理者'
      it { is_expected.to permit(user, User.new) }
    end

    context '権限保持者' do
      include_context 'User'
      it { is_expected.to permit(user, User.new) }
    end

    context '権限非保持者' do
      include_context 'Role'
      it { is_expected.not_to permit(user, User.new) }
    end
  end

  permissions :update? do
    context '管理者' do
      include_context '管理者'
      it { is_expected.to permit(user, User.new) }
    end

    context '権限保持者' do
      include_context 'User'
      it { is_expected.to permit(user, User.new) }
    end

    context '権限非保持者' do
      include_context 'Role'
      it { is_expected.not_to permit(user, User.new) }
    end
  end

  permissions :edit? do
    context '管理者' do
      include_context '管理者'
      it { is_expected.to permit(user, User.new) }
    end

    context '権限保持者' do
      include_context 'User'
      it { is_expected.to permit(user, User.new) }
    end

    context '権限非保持者' do
      include_context 'Role'
      it { is_expected.not_to permit(user, User.new) }
    end
  end

  permissions :destroy? do
    context '管理者' do
      include_context '管理者'
      it { is_expected.to permit(user, User.new) }
    end

    context '権限保持者' do
      include_context 'User'
      it { is_expected.to permit(user, User.new) }
    end

    context '権限非保持者' do
      include_context 'Role'
      it { is_expected.not_to permit(user, User.new) }
    end
  end
end
