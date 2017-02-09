Rails.application.routes.draw do
  devise_for :users
  get 'about' => 'welcome#about'
  get 'show' => 'users#show'
  get 'manage_account' => 'charges#new'

  resources :wikis do
    resources :collaborators
  end
  resources :charges, only: [:new, :create]
  get 'downgrade' => 'charges#downgrade'
  get 'remove_collaborator' => 'collaborators#destroy'
  root 'welcome#index'
end
