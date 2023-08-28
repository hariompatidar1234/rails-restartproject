Rails.application.routes.draw do
  resources :books, only: %i[show create update destroy]

  resources :admins
  resources :members
  post '/members/login', to: 'members#login'

  resources :users

  resources :books
end
