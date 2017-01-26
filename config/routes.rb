Rails.application.routes.draw do
  devise_for :users
  get 'about' => 'welcome#about'
  get 'show' => 'users#show'

  resources :wikis

  root 'welcome#index'
end
