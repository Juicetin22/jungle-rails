class SessionsController < ApplicationController

  def new
  end

  def create
    # if user exists using authenticate_with_credentials method
    if user = User.authenticate_with_credentials(params[:email], params[:password])
      # save user_id as cookie and login user
      session[:user_id] = user.id
      redirect_to '/'
    else
    # if user's login fails, redirect to login page
      redirect_to '/login'
    end
  end

  def destroy
    session[:user_id] = nil
    redirect_to '/login'
  end

end
