class Rating < ApplicationRecord
  belongs_to :book
  belongs_to :member
  belongs_to :order
  validates :rate, presence: true, inclusion: { in: 1..5, message: 'should be between 1 and 5' }
  validates :comment, length: { maximum: 150 }
end
