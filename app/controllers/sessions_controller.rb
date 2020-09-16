class SessionsController < ApplicationController
  def new
  end
  
  def create
    user = User.find_by(email: params[:session][:email].downcase)
    
    if user && user.authenticate(params[:session][:password])
      reset_session
      session[:user_id] = user.id
      redirect_to home_path
    else
      flash[:error] = "Invalid email/password combination"
      redirect_to login_path
    end
  end
  
  def destroy
    session.delete(:user_id)
    flash[:info] = "You're logged out"
    redirect_to root_path
  end
end
