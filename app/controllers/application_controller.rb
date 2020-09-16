class ApplicationController < ActionController::Base
  
  private
    def current_user
      if session[:user_id]
        @current_user ||= User.find_by(id: session[:user_id])
      end
    end

    def authenticate
      if current_user.nil?
        flash[:error] = "Please log in to view this page."
        redirect_to login_path
      end
    end
end
