class UsersController < ApplicationController

  def new
  end
  
  def create
    # create new user in database using params from registration form
    user = User.new(user_params)
    # if validations pass and there are no issues in saving the user, then log user in
    if user.save
      session[:user_id] = user.id
      redirect_to '/'
    else
      redirect_to '/signup'
    end
  end

  private

  def user_params
    params.require(:user).permit(
      :first_name, 
      :last_name, 
      :email, 
      :password, 
      :password_confirmation
    )
  end
  
end
