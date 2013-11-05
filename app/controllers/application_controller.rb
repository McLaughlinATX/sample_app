class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  # Include the SessionsHelper for some methods to remember 
  # when signed-in
  # --- By default, all the helpers are available in the views
  # --- but not in the controllers.  We need the methods from 
  # --- the Sessions helper in both places, so we have to 
  # --- explicitly include it
  include SessionsHelper

end
