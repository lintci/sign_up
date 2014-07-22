Rails.application.routes.draw do
  constraints subdomain: 'www' do
    get ':any', to: redirect(subdomain: nil, path: '/%{any}'), any: /.*/
  end

  root to: 'visitors#show'

  resources :visitors, only: [:index, :create]

  devise_for :users
  resources :users
end
