Rails.application.routes.draw do
  get 'sessions/new'

  get 'users/index'

  get 'users/show'

  get 'users/destroy'

  root 'static_pages#home'
  get 'signup' => 'users#new'
  get 'login' => 'sessions#new'
  post 'login' => 'sessions#create'
  delete 'logout' => 'sessions#destroy'
  
  # resources :users

  resources :users do
    member do
      get :followers, :following
    end
  end

  resources :relationships, only: [:create, :destroy]
  resources :entries, only: [:create, :destroy]
  resources :comments, only: [:create, :destroy]
end
