#
# index
#
shared_examples 'Role indexができる' do
  before { get :index }
  subject { assigns(:roles) }

  it { is_expected.to include only_view_role }
  it_behaves_like 'http code', 200
end

shared_examples 'Role indexができない' do
  before { get :index }

  it_behaves_like 'http code', 404
end

#
# show
#
shared_examples 'Role showができる' do
  before { get :show, id: only_view_role.to_param }
  subject { assigns(:role) }

  it { is_expected.to eq only_view_role }
  it_behaves_like 'http code', 200
end

shared_examples 'Role showができない' do
  before { get :show, id: only_view_role.to_param }

  it_behaves_like 'http code', 404
end

#
# new
#
shared_examples 'Role newができる' do
  before { get :new }
  subject { assigns(:role) }

  it { is_expected.to be_a_new(Role) }
  it_behaves_like 'http code', 200
end

shared_examples 'Role newができない' do
  before { get :new }

  it_behaves_like 'http code', 404
end

#
# edit
#
shared_examples 'Role editができる' do
  before { get :edit, id: only_view_role.to_param }
  subject { assigns(:role) }

  it { is_expected.to eq only_view_role }
  it_behaves_like 'http code', 200
end

shared_examples 'Role editができない' do
  before { get :edit, id: only_view_role.to_param }

  it_behaves_like 'http code', 404
end

#
# create
#
shared_examples 'Role createができる' do
  context 'with valid params' do
    before { post :create, role: valid_attributes }

    it_behaves_like 'http code', 302

    context 'creates a new Role' do
      subject { Role.count }

      it { is_expected.to eq 2 }
    end

    context 'assigns a newly created role as @role' do
      subject { assigns(:role) }

      it { is_expected.to be_a Role }
      it { is_expected.to be_persisted }
    end

    context 'inside @role' do
      it { expect(assigns(:role).name).to eq valid_attributes['name'] }

      context 'ability' do
        subject { assigns(:role).ability }

        it { is_expected.to include foo_index.domain }

        context 'inside ability' do
          subject { assigns(:role).ability[foo_index.domain] }

          it do
            is_expected.to include(
              { foo_index.ability => foo_index.id },
              { foo_show.ability => foo_show.id },
              { foo_create.ability => foo_create.id }
            )
          end
        end
      end
    end

    context 'redirects to the created role' do
      subject { response }

      it { is_expected.to redirect_to Role.last }
    end
  end

  context 'with invalid params' do
    before do
      allow_any_instance_of(Role).to receive(:save).and_return(false)
      post :create, role: { 'name': 'invalid value' }
    end

    it_behaves_like 'http code', 200

    context 'assigns a newly created but unsaved role as @role' do
      subject { assigns(:role) }

      it { is_expected.to be_a_new Role }
    end

    context "re-renders the 'new' template" do
      subject { response }

      it { is_expected.to render_template('new') }
    end
  end
end

shared_examples 'Role createができない' do
  before { post :create, role: valid_attributes }

  it_behaves_like 'http code', 404
end

#
# update
#
shared_examples 'Role updateができる' do
  context 'with valid params' do
    context 'all update' do
      before do
        put :update, id: only_view_role.to_param, role: all_update
        only_view_role.reload
      end

      it_behaves_like 'http code', 302

      context 'updates the requested role' do
        subject { only_view_role.name }

        it { is_expected.to eq all_update['name'] }

        context 'update ability id' do
          subject { only_view_role.ability_id_to_a }

          it { is_expected.to eq all_update['roles_abilities_attributes'].map { |i| i['ability_id'].to_i } }
        end
      end

      context 'assigns the requested role as @role' do
        subject { assigns(:role) }

        it { is_expected.to eq only_view_role }
      end

      context 'redirects to the role' do
        subject { response }

        it { is_expected.to redirect_to only_view_role }
      end
    end

    context 'some update' do
      before do
        put :update, id: only_view_role.to_param, role: some_update
        only_view_role.reload
      end

      it_behaves_like 'http code', 302

      context 'updates the requested role' do
        subject { only_view_role.name }

        it { is_expected.to eq some_update['name'] }

        context 'update ability id' do
          subject { only_view_role.ability_id_to_a }

          it { is_expected.to eq some_update['roles_abilities_attributes'].map { |i| i['ability_id'].to_i } }
        end
      end

      context 'assigns the requested role as @role' do
        subject { assigns(:role) }

        it { is_expected.to eq only_view_role }
      end

      context 'redirects to the role' do
        subject { response }

        it { is_expected.to redirect_to only_view_role }
      end
    end

    context 'not update' do
      before do
        put :update, id: only_view_role.to_param, role: not_update
        only_view_role.reload
      end

      it_behaves_like 'http code', 302

      context 'updates the requested role' do
        subject { only_view_role.name }

        it { is_expected.to eq '参照権限' }

        context 'update ability id' do
          subject { only_view_role.ability_id_to_a }

          it { is_expected.to eq not_update['roles_abilities_attributes'].map { |i| i['ability_id'].to_i } }
        end
      end

      context 'assigns the requested role as @role' do
        subject { assigns(:role) }

        it { is_expected.to eq only_view_role }
      end

      context 'redirects to the role' do
        subject { response }

        it { is_expected.to redirect_to only_view_role }
      end
    end
  end

  context 'with invalid params' do
    before do
      put :update, id: only_view_role.to_param, role: { 'name': 'invalid value' }
    end

    it_behaves_like 'http code', 200

    context 'assigns the role as @role' do
      subject { assigns(:role) }

      it { is_expected.to eq only_view_role }
    end

    context "re-renders the 'edit' template" do
      subject { response }

      it { is_expected.to render_template('edit') }
    end
  end
end

shared_examples 'Role updateができない' do
  before { put :update, id: only_view_role.to_param, role: all_update }

  it_behaves_like 'http code', 404
end

#
# destroy
#
shared_examples 'Role destroyができる' do
  before { delete :destroy, id: only_view_role.to_param }

  context 'destroys the requested role' do
    subject { Role.count }

    it { is_expected.to eq 1 }
  end

  context 'redirects to the roles list' do
    subject { response }

    it { is_expected.to redirect_to roles_url }
  end
end

shared_examples 'Role destroyができない' do
  before { delete :destroy, id: only_view_role.to_param }

  it_behaves_like 'http code', 404
end
