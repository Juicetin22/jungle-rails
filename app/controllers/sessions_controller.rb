class SessionsController < ApplicationController

  def new
  end

  def create
    user = User.find_by_email(params[:email])
    # if user exists AND the password entered is correct, save user_id as cookie and login user
    if user && user.authenticate(params[:password])
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
