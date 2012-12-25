class SessionsController < ApplicationController
  def new
  	if session[:user_id]
  		redirect_to outbox_path
  	end
  end

  def create
    user = User.find_by_email(params[:email])
    if user && user.authenticate(params[:password])
      cookies.permanent[:auth_token] = user.auth_token
      session[:user_id] = user.id
      redirect_to outbox_path
    else
      flash.now.alert = "Invalid email or password"
      render "new"
    end
  end

  def destroy
    cookies.delete(:auth_token)
    session[:user_id] = nil
    redirect_to root_url
  end
end