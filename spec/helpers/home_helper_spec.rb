require 'spec_helper'

describe HomeHelper do
  describe ".user_index?" do
    context '管理者' do
      include_context "管理者"
      subject { user_index?(user) }
      it { is_expected.to be_truthy }
    end

    context '権限保持者' do
      include_context "User"
      subject { user_index?(user) }
      it { is_expected.to be_truthy }
    end

    context '権限非保持者' do
      include_context "Role"
      subject { user_index?(user) }
      it { is_expected.to be_falsey }
    end
  end

  describe ".role_index?" do
    context '管理者' do
      include_context "管理者"
      subject { role_index?(user) }
      it { is_expected.to be_truthy }
    end

    context '権限保持者' do
      include_context "Role"
      subject { role_index?(user) }
      it { is_expected.to be_truthy }
    end

    context '権限非保持者' do
      include_context "User"
      subject { role_index?(user) }
      it { is_expected.to be_falsey }
    end
  end
end
