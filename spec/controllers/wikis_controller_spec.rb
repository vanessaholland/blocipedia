require 'rails_helper'

RSpec.describe WikisController, type: :controller do
  before :example do
    @user = create :user
    sign_in @user
    @wiki = create :wiki
  end

  context
  describe 'GET index' do
    it 'returns http success' do
      get :index
      expect(response).to have_http_status(:success)
    end
    it 'renders index template template' do
      get :index
      expect(response).to render_template(:index)
    end
  end

  describe 'GET show' do
    let(:request) { get :show, params: { id: @wiki.id } }
    it 'returns http success' do
      request
      expect(response).to have_http_status(:success)
    end

    it 'renders show template' do
      request
      expect(response).to render_template(:show)
    end
    it 'assigns my_wiki to @wiki' do
      get :show, params: { id: @wiki.id }
      expect(assigns(:wiki)).to eq(@wiki)
    end
  end

  describe 'GET new' do
    it 'returns http success' do
      get :new
      expect(response).to have_http_status(:success)
    end
    it 'renders new template' do
      get :new
      expect(response).to render_template(:new)
    end
  end

  describe 'GET edit' do
    let(:request) { get :edit, params: { id: @wiki.id } }

    it 'returns http success' do
      request
      expect(response).to have_http_status(:success)
    end
    it 'renders edit template' do
      request
      expect(response).to render_template(:edit)
    end
  end
  describe 'DELETE destroy' do
    it 'returns http redirect' do
      delete :destroy, params: { id: @wiki.id }
      expect(response).to redirect_to(wikis_path)
    end
  end
end
