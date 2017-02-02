require 'rails_helper'

RSpec.describe UsersController, type: :controller do
  let(:user) { create(:user) }

  it { is_expected.to have_many(:wikis) }
  it { is_expected.to have_many(:charges) }

  context 'guest' do
    describe 'GET show' do
      it 'returns http redirect' do
        get :show, params: { id: user.id }
        expect(response).to redirect_to(new_user_session_path)
      end
    end
  end

  context 'standard user' do
    before do
      sign_in(user)
    end
    describe 'GET show' do
      it 'returns http success' do
        get :show, params: { id: user.id }
        expect(response).to have_http_status(:success)
      end
      it 'renders the show view' do
        get :show, params: { id: user.id }
        expect(response).to render_template(:show)
      end
    end
  end

  context 'premium user' do
    before do
      sign_in(user)
    end
    describe 'GET show' do
      it 'returns http success' do
        get :show, params: { id: user.id }
        expect(response).to have_http_status(:success)
      end

      it 'renders the show view' do
        get :show, params: { id: user.id }
        expect(response).to render_template(:show)
      end
    end
  end
end
