class User < ApplicationRecord
  USER_PERMIT = %i(name email password password_confirmation).freeze

  validates :name, presence: true,
    length: {maximum: Settings.user.validate.name_max}
  validates :email, presence: true,
    length: {maximum: Settings.user.validate.email_max},
    format: {with: URI::MailTo::EMAIL_REGEXP}, uniqueness: true
  validates :password, presence: true,
    length: {minimum: Settings.user.validate.pass_min}

  has_secure_password

  before_save :downcase_email

  private

  def downcase_email
    email.downcase!
  end
end
