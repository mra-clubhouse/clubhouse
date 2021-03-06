Rails.application.routes.draw do
  root to: "static_pages#home"

  devise_for :users, controllers: {
    sessions: "users/sessions"
  }

  resources :posts do
    resources :comments, only: [:create, :update, :destroy]
  end

  resources :messages, only: [:index, :create]
end
