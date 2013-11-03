class UsersController < ApplicationController
  
  # here we can define variables for the views based on this controller

  # define the ACTION for the 'show' VIEW
  def show
  	# somehow params[:id] will return the DB ID of the user we are showing
  	@user = User.find(params[:id])
  end

  # define the ACTION for sign-up a 'new' user VIEW
  def new
  	# define a user to fill out the form HTML
  	@user = User.new
  end

  # define the ACTION to create user
  def create
    
    @user = User.new(user_params)
    
    if @user.save
      # Handle a successful save.
      flash[:success] = "Welcome to the Sample App!"

      # Now render the newly created user's page
      redirect_to @user
    else
      render 'new'
    end

  end


  # define private methods
  private

    def user_params
      params.require(:user).permit(	:name, 
      															:email, 
      															:password,
                                   	:password_confirmation)
    end # end user_params

end
