class User < Member
  validate :unique_email_for_users

  private

  def unique_email_for_users
    return unless User.exists?(email: email)

    errors.add(:email, 'has already been taken by a user')
  end
end
