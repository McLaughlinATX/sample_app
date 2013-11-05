class User < ActiveRecord::Base

	# call the magic secure password method
  has_secure_password

  # ensure email is lowercase (to help ensure uniqueness)
  before_save { self.email = email.downcase }
  # --- alternate format ---
	#before_save { email.downcase! }

	# remember the user's token before creating it in the model
	before_create :create_remember_token

	# NOTES:
	# Model-level validations are the best way to ensure that 
	# only valid data is saved into your database.	

	# validate name is provided and a valid length
	validates :name, presence: true, length: { maximum: 50 }
	
	# validate email format is valid and unique
	VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z]+)*\.[a-z]+\z/i
  validates :email, presence: true, format: { with: VALID_EMAIL_REGEX },
  									uniqueness: { case_sensitive: false }


	# validate the password meets our minimum criteria
  validates :password, length: { minimum: 6 }


  # "Static" method which generates a new token
  def User.new_remember_token
    SecureRandom.urlsafe_base64
  end

  # "Static" method which encrypts the supplied token
  def User.encrypt(token)
    Digest::SHA1.hexdigest(token.to_s)
  end


  private

  	# Create token, encrypt it, and assign it to remember_token
    def create_remember_token
      self.remember_token = User.encrypt(User.new_remember_token)
    end

end
