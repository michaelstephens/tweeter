Rails.application.routes.draw do
  root "user_sessions#new"

  resources :users
  resources :user_sessions
  resources :posts
  resources :blogs
  resources :comments, except: [:index, :show]

  get 'login' => 'user_sessions#new', :as => :login
  get 'logout' => 'user_sessions#destroy', :as => :logout
end
