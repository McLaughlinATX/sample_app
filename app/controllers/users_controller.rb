class UsersController < ApplicationController
  
  # here we can define variables for the views based on this controller

  # --- LIST ALL BEFORE ACTIONS ---

  # before the index, edit & update ACTIONS ... call signed_in_user
  before_action :signed_in_user, only: [:index, :edit, :update]

  # before the edit & update ACTIONS ... call correct_user
  before_action :correct_user,   only: [:edit, :update]

  # before the detroy ACTION ... only allow if this is an admin
  before_action :admin_user,     only: :destroy

  # --- LIST ALL ACTIONS ---
  
  # define the ACTION for the 'index' VIEW
  def index

    @users = User.paginate(page: params[:page])

  end


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

      # Sign the user in
      sign_in @user

      # Handle a successful save.
      flash[:success] = "Welcome to the Sample App!"

      # Now render the newly created user's page
      redirect_to @user
    else
      render 'new'
    end

  end # end def create


  # define the ACTION to edit user
  def edit

  end


  # define the ACTION to update user
  def update

    if @user.update_attributes(user_params)
     
      # Handle a successful update.
      flash[:success] = "Profile updated"
      redirect_to @user

    else
     
      render 'edit'
    
    end

  end # end update


  # define the ACTION to destroy user
  def destroy
    User.find(params[:id]).destroy
    flash[:success] = "User deleted."
    redirect_to users_url
  end



  # --- define private methods ---
  private

    def user_params
      params.require(:user).permit(	:name, 
      															:email, 
      															:password,
                                   	:password_confirmation)
    end # end user_params


    # --- Before filters functions ---

    def signed_in_user

      unless signed_in?
        store_location
        redirect_to signin_url, notice: "Please sign in."
      end

    end

    # the above function is equivalent to this more verbose version:
    #unless signed_in?
    #  flash[:notice] = "Please sign in."
    #  redirect_to signin_url
    #end


    def correct_user

      # Recall that the id of the user is available in the params[:id] variable
      @user = User.find(params[:id])
      
      redirect_to(root_url) unless current_user?(@user)
    end


    def admin_user

      redirect_to(root_url) unless current_user.admin?

    end


end # Users Controller
