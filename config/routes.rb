Rails.application.routes.draw do
  constraints subdomain: nil do
    get ':any', to: redirect(subdomain: 'www', path: '/%{any}'), any: /.*/
  end

  root to: 'visitors#show'

  resources :visitors, only: [:index, :create]

  devise_for :users
  resources :users
end
