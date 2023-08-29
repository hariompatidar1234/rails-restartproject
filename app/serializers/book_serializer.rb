class BookSerializer < ActiveModel::Serializer
  attributes :id, :title, :author, :price, :quantity, :member_id
end
