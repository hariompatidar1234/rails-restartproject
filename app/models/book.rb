class Book < ApplicationRecord
  has_many :orders, dependent: :destroy
  has_many :ratings, dependent: :destroy
  belongs_to :member
  validates :title, uniqueness: true
  validates :author, :title, presence: true
  validates :quantity, numericality: { only_integer: true, greater_than_or_equal_to: 0 }
  before_create :set_default_quantity
  validate :admin_only_add_book

  private
  def admin_only_add_book
    unless user.type == "Admin"
      errors.add(:base, "Only Admin have permission to add Books.")      
    end
  end
  private

  def set_default_quantity
    self.quantity ||= 0
  end
end
