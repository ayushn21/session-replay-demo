class ApplicationController < ActionController::Base
  
  private
    def current_user
      if (user_id = session[:user_id])
        user = User.find_by(id: user_id)
      
        if user && user.authenticated?(session[:token])
          @current_user ||= user
        end
      end
    end

    def authenticate
      if current_user.nil?
        flash[:error] = "Please log in to view this page."
        redirect_to login_path
      end
    end
end
