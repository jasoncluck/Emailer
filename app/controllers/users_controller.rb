class UsersController < ApplicationController
	def new
		@user = User.new
	end

	def create
		@user = User.new(params[:user])
		if (Figaro.env.ra_emails.include? @user.email) && @user.save 
			session[:user_id] = @user.id
			# Switch the admin boolean if this user is an admin
			if (Figaro.env.sender_email.include? @user.email) || (Figaro.env.admin_emails.include? @user.email)
				@user.admin = true
				@user.save
			end
			redirect_to root_url, notice: "Thank you for signing up!"
		else
			flash[:notice] = 'Username is invalid or already taken. Access is restricted to Korok Ray\'s research assistants.  Contact jcluck@gwmail.gwu.edu with any questions'
			render "new"
		end
	end
end
