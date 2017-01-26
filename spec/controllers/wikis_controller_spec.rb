require 'rails_helper'

RSpec.describe WikisController, type: :controller do
  let(:my_wiki) { Post.create!(title: 'Wiki Title', body: 'Random paragraph and such ') }
  describe 'GET #index' do
    it 'returns http success' do
      get :index
      expect(response).to have_http_status(:success)
    end
  end

  describe 'GET #show' do
    it 'returns http success' do
      get :show, params: { id: my_wiki.id }
      expect(response).to have_http_status(:success)
    end

    it 'renders the #show view' do
      get :show, params: { id: my_wiki.id }
      expect(response).to render_template :show
    end

    it 'assigns my_wiki to @wiki' do
      get :show, params: { id: my_wiki.id }
      expect(assigns(:wiki)).to eq(my_wiki)
    end
  end

  describe 'GET #new' do
    it 'returns http success' do
      get :new
      expect(response).to have_http_status(:success)
    end

    it 'renders the #new view' do
      get :new
      expect(response).to render_template :new
    end

    it 'instantiates @wiki' do
      get :new
      expect(assigns(:wiki)).not_to be_nil
    end
  end

  describe 'GET #edit' do
    it 'returns http success' do
      get :edit, params: { id: my_wiki.id }
      expect(response).to have_http_status(:success)
    end
  end

  describe 'POST create' do
    it 'increases the number of Wiki by 1' do
      expect { post :create, wiki: { title: 'A new wiki title', body: 'A new wiki body paragraph yay!' } }.to change(Wiki, :count).by(1)
    end

    it 'assigns the new wiki to @wiki' do
      post :create, wiki: { title: 'Random wiki title', body: 'A new random body paragraph goes here' }
      expect(assigns(:wiki)).to eq Wiki.last
    end

    it 'redirects to the new wiki' do
      post :create, wiki: { title: 'RandomData.random_sentence', body: 'RandomData.random_paragraph' }
      expect(response).to redirect_to Wiki.last
    end
  end

  describe 'GET #update' do
    it 'returns http success' do
      get :update
      expect(response).to have_http_status(:success)
    end
  end

  describe 'GET #destroy' do
    it 'returns http success' do
      get :destroy
      expect(response).to have_http_status(:success)
    end
  end
end
