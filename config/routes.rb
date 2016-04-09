Rails.application.routes.draw do
  root "posts#index"

  resources :users, only: [:index]
  resources :posts
  resources :comments, except: [:index, :show]
end
