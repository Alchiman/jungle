class User < ActiveRecord::Base
  has_secure_password
  validates :password, confirmation: true , presence: true, length: { in: 6..20 }
  validates :password_confirmation, presence: true
  validates :email, presence: true
  validates :name, presence: true
  validates :email, uniqueness: { case_sensitive: false }

  def self.authenticate_with_credentials(email, password)
    user = where('LOWER(email) = ?', email.downcase.delete(' '))[0]
    user && user.authenticate(password)
end
  
end
