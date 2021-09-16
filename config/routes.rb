Rails.application.routes.draw do
  resources :users

  resources :posts do
    resources :comments
  end

  resources :messages
end
