class Cart < ApplicationRecord
  belongs_to :book
  has_many :orders
  belongs_to :member

  validates :quantity, numericality: { only_integer: true, greater_than_or_equal_to: 0 }
  validate :validate_cart_quantity

  before_create :update_book_quantity

  private

  def validate_cart_quantity
    if quantity <= 0
      errors.add(:quantity, "must be greater than 0")
    elsif quantity > book.quantity
      errors.add(:quantity, "cannot exceed available stock")
    end
  end

  def update_book_quantity
    remaining_quantity = book.quantity - quantity
    if remaining_quantity >= 0
      book.update(quantity: remaining_quantity)
    else
      errors.add(:quantity, "exceeds available stock")
      throw(:abort)
    end
  end
end
