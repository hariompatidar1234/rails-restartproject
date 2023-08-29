class UserSerializer < ActiveModel::Serializer
  attributes :id, :name, :email, :contact
end
