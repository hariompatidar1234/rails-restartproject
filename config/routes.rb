Rails.application.routes.draw do
  resources :admins, only: %i[show create update destroy]
  post '/admins_login', to: 'admins#login'
  resources :users, only: %i[show create update destroy]
  post '/users_login', to: 'users#login'
  resources :books, only: %i[show create update destroy]
end
# config/routes.rb
