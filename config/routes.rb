 Rails.application.routes.draw do
  # post 'members_login', to: 'members#login'
  resource :members
# GET    /members          -> members#index
# POST   /members          -> members#create
# GET    /members/:id      -> members#show
# PATCH  /members/:id      -> members#update
# PUT    /members/:id      -> members#update
# DELETE /members/:id      -> members#destroy

end
# # config/routes.rb

# Rails.application.routes.draw do
#   resources :members, only: [:create, :update, :destroy, :show] do
#     collection do
#       post 'login'
#     end
#   end
  
#   resources :books
# end
