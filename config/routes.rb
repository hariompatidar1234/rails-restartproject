# Rails.application.routes.draw do
#   post 'members_login', to: 'members#login'
#   get 'members_show',to: 'membersshow'
#   resource :members
# end
# # config/routes.rb

Rails.application.routes.draw do
  resources :members, only: [:create, :update, :destroy, :show] do
    collection do
      post 'login'
    end
  end
  
  resources :books
end
