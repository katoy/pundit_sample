require 'spec_helper'

describe RolesHelper do
  describe '.role_show?' do
    context '管理者' do
      include_context '管理者'
      subject { role_show?(user) }
      it { is_expected.to be_truthy }
    end

    context '権限保持者' do
      include_context 'Role'
      subject { role_show?(user) }
      it { is_expected.to be_truthy }
    end

    context '権限非保持者' do
      include_context 'User'
      subject { role_show?(user) }
      it { is_expected.to be_falsey }
    end
  end

  describe '.role_edit?' do
    context '管理者' do
      include_context '管理者'
      subject { role_edit?(user) }
      it { is_expected.to be_truthy }
    end

    context '権限保持者' do
      include_context 'Role'
      subject { role_edit?(user) }
      it { is_expected.to be_truthy }
    end

    context '権限非保持者' do
      include_context 'User'
      subject { role_edit?(user) }
      it { is_expected.to be_falsey }
    end
  end

  describe '.role_destroy?' do
    context '管理者' do
      include_context '管理者'
      subject { role_destroy?(user) }
      it { is_expected.to be_truthy }
    end

    context '権限保持者' do
      include_context 'Role'
      subject { role_destroy?(user) }
      it { is_expected.to be_truthy }
    end

    context '権限非保持者' do
      include_context 'User'
      subject { role_destroy?(user) }
      it { is_expected.to be_falsey }
    end
  end

  describe '.role_create?' do
    context '管理者' do
      include_context '管理者'
      subject { role_create?(user) }
      it { is_expected.to be_truthy }
    end

    context '権限保持者' do
      include_context 'Role'
      subject { role_create?(user) }
      it { is_expected.to be_truthy }
    end

    context '権限非保持者' do
      include_context 'User'
      subject { role_create?(user) }
      it { is_expected.to be_falsey }
    end
  end
end
