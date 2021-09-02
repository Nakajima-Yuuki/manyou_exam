Rails.application.routes.draw do
  get 'sessions/new'
  root 'tasks#index'
  resources :tasks
  namespace :admin do
    resources :users 
    resources :labels
end
  resources :users, only: [:new, :create, :show, :edit, :update]
  resources :sessions, only: [:new, :create, :destroy]
end
