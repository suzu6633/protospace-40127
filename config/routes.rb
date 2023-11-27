Rails.application.routes.draw do
  devise_for :users
  root to: "prototypes#index"
  resources :users, only: [:show]
  resources :prototypes do
  # resources :prototypes, only: [:index, :new, :create, :show, :edit, :update, :destroy]
  resources :comments, only: [:create, :show]
  end
end