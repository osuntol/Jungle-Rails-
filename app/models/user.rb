class User < ApplicationRecord



has_secure_password


  validates :email, presence: true, uniqueness: {case_sensitive: false}
  validates :first_name, presence: true
  validates :last_name, presence: true
  validates :password, presence: true, length: { minimum: 7 }, on: :create



before_save do 
  self.email = self.email.downcase
 end

 def self.authenticate_with_credentials(email, password)
  email = email.strip
  email = email.downcase
  user = User.find_by(email: email)
    if user.present? && user.authenticate(password)
      return user 
    else
      return nil
    end
 end 
end

