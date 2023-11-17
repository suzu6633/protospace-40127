Rails.application.routes.draw do
  devise_for :users
  root to: "prototypes#index"
  resources :users
  resources :prototypes do
    resources :comments, only: [:create, :show]
  end
end