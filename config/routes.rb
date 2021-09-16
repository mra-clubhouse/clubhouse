Rails.application.routes.draw do
  root to: "static_pages#home"

  devise_for :users

  resources :users

  resources :posts do
    resources :comments
  end

  resources :messages
end
