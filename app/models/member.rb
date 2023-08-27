class Member < ApplicationRecord
	has_many :books, dependent: :destroy
	has_many :orders, dependent: :destroy
  has_many :ratins, dependent: :destroy
  ROLES = %w[user admin].freeze

  scope :admins, -> { where(role: "admin") }
  scope :users, -> { where(role: "user") }

  validates :name, :address, :email, :password, :contact, :role, presence: true
  validates :role, inclusion: { in: ROLES }
  validates :name,:email,:password, uniqueness: true
  validates :password, length:  { in: 6..12 }
  validates :name, length: { minimum: 2 }, format: { with: /\A[a-zA-Z]+ *[a-zA-Z]*\z/ }
  validates :contact, format: { with: /\A\d{10}\z/, message: "should be 10 digits" }
  validates :address, format: { with: /\A[\w\s]+\z/, message: "only allows letters, digits, and spaces" }
  validate :unique_email_for_users_and_admins

  def unique_email_for_users_and_admins
  existing_member = Member.find_by(email: email)
  
  if existing_member && existing_member.role.in?(["user", "admin"]) && (new_record? || existing_member.id != id)
    errors.add(:email, "has already been taken by a user or admin")
  end
end


end
