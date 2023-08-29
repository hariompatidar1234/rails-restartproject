Rails.application.routes.draw do
  # resources :admins
  # resources :users
  resources :books
  resources :orders
  resources :ratings
  resources :members
  post '/members/login', to: 'members#login'

  # resources :books, except: [:new, :edit] do
  #   resources :ratings, only: [:index, :create]
  # end
  # # resources :members, only: [:index, :create] do
  # #   post 'login', on: :collection
  # # end
  # resources :orders, except: [:new, :edit]
  resources :users, except: %i[new edit]
  resources :admins, only: [:create]
end
