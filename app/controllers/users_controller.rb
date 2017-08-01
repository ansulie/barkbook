class UsersController < ApplicationController
	before_action :require_user, only: [:show]
	# before_action :require_current_user, only: [:show]
	before_action :logged_in, only: [:show, :index]


	def show
		@user_all = User.all
		@user = User.find(params[:id])
		@params= params[:search]
		@park = @user.parks
	end

	def new
		@user = User.new

	end
	#probably not going to use this one either
	def edit
		@user = User.find(params[:id])
	end

	def create
		@user = User.new(user_params)
		# @user[:address] = 'New York'
		if @user.save
			session[:user_id] = @user.id
			redirect_to @user
		else
			render :action => :new
		end
	end
	#not sure if we need this route. A lot of websites don't let users (easily) delete accounts,
	#not really a priority
	def destroy
		@user = User.find(params[:id])
		@user.destroy
		redirect_to "/users"
	end

	private

	def user_params
		params.require(:user).permit(:name, :email, :password_digest, :avatar, :password, :password_confirmation, :address)
	end

end
