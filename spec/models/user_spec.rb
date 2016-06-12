require 'spec_helper'

describe User do
  let(:administrator) { FG.create(:administrator) }
  let(:has_user_authority) { FG.create(:has_user_authority) }
  let(:has_role_authority) { FG.create(:has_role_authority) }

  describe 'relationship' do
    it { is_expected.to belong_to(:role) }
  end

  describe '#ability' do
    context 'administrator' do
      subject { administrator.ability }

      it { is_expected.to include 'admin' }

      describe "['admin']" do
        subject { super()['admin'] }
        it { is_expected.to include 'admin' }
      end
    end

    context 'has_user_authority' do
      subject { has_user_authority.ability }

      it { is_expected.to include 'user' }

      describe "['user']" do
        subject { super()['user'] }
        it { is_expected.to include('index', 'show', 'create', 'update', 'destroy') }
      end
    end

    context 'has_role_authority' do
      subject { has_role_authority.ability }

      it { is_expected.to include 'role' }

      describe "['role']" do
        subject { super()['role'] }
        it { is_expected.to include('index', 'show', 'create', 'update', 'destroy') }
      end
    end
  end
end
