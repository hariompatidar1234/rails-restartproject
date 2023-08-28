Rails.application.routes.draw do
  resources :admins
  resources :users
  resources :books
  resources :orders
  resources :ratings
  resources :members
  post '/members/login', to: 'members#login'


end
