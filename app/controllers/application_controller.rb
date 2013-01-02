class ApplicationController < ActionController::Base
  protect_from_forgery
  

 	private
  	def current_user
    	@current_user ||= User.find(session[:user_id]) if session[:user_id]
  	end
  	helper_method :current_user

  	def admin_authorize
  		  redirect_to login_url, alert: "Not authorized - must be admin" if current_user == nil or current_user.email != Figaro.env.sender_email
	  end

	def general_authorize
        redirect_to login_url, alert: "Not authorized" if current_user.nil?
	end
end