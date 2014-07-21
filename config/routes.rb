Rails.application.routes.draw do
  root to: 'visitors#show'

  resources :visitors, only: [:index, :create]

  devise_for :users
  resources :users
end
