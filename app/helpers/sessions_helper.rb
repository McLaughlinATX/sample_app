module SessionsHelper

  def sign_in(user)

  	# Create a new token
    remember_token = User.new_remember_token

    # Put the new token into the cookie w/ a permanent expiration
    cookies.permanent[:remember_token] = remember_token

    # Update the user record in the db w/ the encrypted form of the token
    user.update_attribute(:remember_token, User.encrypt(remember_token))

    # Capture the current user
    self.current_user = user
  end


  def signed_in?
    !current_user.nil?
  end
  

  def current_user=(user)
    @current_user = user
  end

  def current_user
  	# Encrypt the cookie's token 
    remember_token = User.encrypt(cookies[:remember_token])

    # Use the encrypted cookie's token to query for the current user
    # ---    ||= means "or equals"
    # --- this cryptic operator only sets the value if the left side is undefined
    @current_user ||= User.find_by(remember_token: remember_token)

  end

  def current_user?(user)
    user == current_user
  end
  

  def sign_out
    # Clear out the current user
    self.current_user = nil

    # Delete the cookie
    cookies.delete(:remember_token)
  end


  def redirect_back_or(default)

    redirect_to(session[:return_to] || default)
    session.delete(:return_to)

  end


  def store_location

    session[:return_to] = request.url if request.get?
  
  end

end