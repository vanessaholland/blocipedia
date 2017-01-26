require 'rails_helper'

RSpec.describe UsersController, type: :controller do
  before do
    @user = create :user
  end

  context 'guest' do
    describe 'GET show' do
      it 'returns http redirect' do
        get :show, params: { id: @user.id }
        expect(response).to redirect_to(new_user_session_path)
      end
    end
  end

  context 'standard user' do
    before do
      sign_in(@user)
    end
    describe 'GET show' do
      it 'returns http success' do
        get :show, params: { id: @user.id }
        expect(response).to have_http_status(:success)
      end
      it 'renders the show view' do
        get :show, params: { id: @user.id }
        expect(response).to render_template(:show)
      end
    end
  end

  context 'premium user' do
    before do
      @premium_user = User.create!(email: 'example@test.com', password: 'password', password_confirmation: 'password', role: 'premium', confirmed_at: Time.now)
      sign_in(@premium_user)
    end
    describe 'GET show' do
      it 'returns http success' do
        get :show, params: { id: @premium_user.id }
        expect(response).to have_http_status(:success)
      end

      it 'renders the show view' do
        get :show, params: { id: @premium_user.id }
        expect(response).to render_template(:show)
      end
    end
  end
end
