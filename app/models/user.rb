class User < ApplicationRecord
CONFIRMATION_TOKEN_EXPIRATION =  15.minutes
attr_accessor :email, :first_name, :last_name



has_secure_password

  before_save :downcase_email

  validates :email, format: {with: URI::MailTo::EMAIL_REGEXP}, presence: true, uniqueness: true

  validates :first_name, presence: true
  validates :last_name, presence: true

def confirm!
  update_columns(confirmed_at: Time.current)
end

def confirmed?
  confirmed_at.present?
end

def generate_confirmation_token
  signed_id expires_in: CONFIRMATION_TOKEN_EXPIRATION, purpose: :confirm_email
end

def unconfirmed?
  !confirmed?
end

private

def downcase_email
  self.email = email.downcase
 end
end
