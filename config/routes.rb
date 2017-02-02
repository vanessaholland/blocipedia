Rails.application.routes.draw do
  devise_for :users
  get 'about' => 'welcome#about'
  get 'show' => 'users#show'
  get 'manage_account' => 'charges#new'

  resources :wikis
  resources :charges, only: [:new, :create]
  get 'downgrade' => 'charges#downgrade'
  root 'welcome#index'
end
