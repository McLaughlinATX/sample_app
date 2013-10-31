class User < ActiveRecord::Base

	# ensure email is lowercase (to help ensure uniqueness)
	before_save { self.email = email.downcase }

	# validate name is provided and a valid length
	validates :name, presence: true, length: { maximum: 50 }
	
	# validate email format is valid and unique
	VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates :email, presence: true, format: { with: VALID_EMAIL_REGEX },
  									uniqueness: { case_sensitive: false }


  # call the magic secure password method
  has_secure_password

	# validate the password meets our minimum criteria
  validates :password, length: { minimum: 6 }

end
