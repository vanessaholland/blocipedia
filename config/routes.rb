Rails.application.routes.draw do
  devise_for :users
  get 'about' => 'welcome#about'

  resources :wikis

  root 'welcome#index'
end
