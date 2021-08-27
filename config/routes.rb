Rails.application.routes.draw do
  root 'tasks#index'
  resources :tasks 
  resources :users
  resources :users, only: [:new, :create, :show, :edit, :update]
end
