class SessionsController < ApplicationController
	before_action :logged_in, only: [:index, :show, :new, :update]

	def new
		if logged_in
			redirect_to action: 'show', controller: 'users', id: current_user.id
		end
	end

	def create
		@user = User.find_by(:email => params[:session][:email])
		if @user && @user.authenticate(params[:session][:password])
			session[:user_id] = @user.id
			redirect_to @user
		else
			redirect_to login_path
		end
	end

	def destroy
		session[:user_id] = nil
		redirect_to login_path
	end

end
