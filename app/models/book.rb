class Book < ApplicationRecord
  has_many :orders,dependent: :destroy
  has_many :ratings,dependent: :destroy
  belongs_to :member
	validates :title, uniqueness: true
  validates :author,:title, presence: true
  validates :quantity,numericality: { only_integer: true, greater_than_or_equal_to: 0 }
  before_create :set_default_quantity

  private

  def set_default_quantity
    self.quantity ||= 0
  end
end
