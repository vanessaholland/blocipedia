require 'rails_helper'

RSpec.describe ChargesController, type: :controller do
  let(:my_user) { create(:user) }
  let(:my_charge) { create(:charge) }

  describe 'GET new' do
    it 'returns http success' do
      get :new
      expect(response).to have_http_status(:success)
    end

    it 'renders the #new view' do
      get :show
      expect(response).to render_template :new
    end
  end
  describe 'GET create' do
    it 'returns http success' do
      get :create
      expect(response).to be_success
    end
  end
end
