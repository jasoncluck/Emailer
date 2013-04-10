class ApplicationController < ActionController::Base
  protect_from_forgery
  

 	private
  	def current_user
    	@current_user ||= User.find(session[:user_id]) if session[:user_id]
  	end
  	helper_method :current_user

  	def admin_authorize
  		  redirect_to login_url, alert: "Not authorized - must be admin" if not Figaro.env.sender_email.include? current_user.email
	  end

	 def general_authorize
        #redirect_to login_url, alert: "Not authorized" if current_user.email != Figaro.env.ra_emails
        redirect_to login_url, alert: "Not authorized" if not Figaro.env.ra_emails.include? current_user.email
	 end
end