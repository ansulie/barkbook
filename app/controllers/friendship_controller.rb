class FriendshipController < ApplicationController
    before_action :require_user
    before_action :logged_in, only: [:show, :index]
    def index
        @users = User.all
        @search = params[:search]
    end

    def show
        @friends = current_user.friends
    end

    def create
        @friendship1 = current_user.friendships.build(:friend_id => params[:friend_id])
        @friendship2 = User.find(params[:friend_id]).friendships.build(:friend_id => current_user.id)
        if @friendship1.save && @friendship2.save
            redirect_to action: 'show', id: current_user.id
        else
            render plain: "couldn't add"
        end
   end

    def destroy
        @friendships =  Friendship.where("user_id = #{params[:id]} and friend_id = #{current_user.id} or user_id = #{current_user.id} and friend_id = #{params[:id]}")
        if @friendships[0].destroy && @friendships[1].destroy
            redirect_to action: 'show', id: current_user.id
        else
            render plain: "guess ya'll are stuck together, best work it out"
        end
    end

end
