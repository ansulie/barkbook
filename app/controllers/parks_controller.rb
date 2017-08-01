class ParksController < ApplicationController
	before_action :require_user
	before_action :logged_in
	include HTTParty

#TA said it should be a create route. It's just fetching data so I don't think that's right but whatever
	def create
		use_latitude = User.find(session[:user_id]).latitude
		use_longitude = User.find(session[:user_id]).longitude

		@search_term = params[:search]
		@range = params[:range]
		park_key = ENV['MAP_API_KEY']
		url = "https://maps.googleapis.com/maps/api/place/nearbysearch/json?key=#{park_key}&location=#{use_latitude},#{use_longitude}"
		response = HTTParty.get(
			url,
			query:{
				types: @search_term,
				keyword:"dog",
				radius:1500
			}
		)
		@parks = response["results"]
		render :new
	end

	#because create is used we're using update to save. I don't feel like fussing with all the form links
  	def update
    	@park = Park.new(parks_params)
    	@park.user_id = current_user.id
    	if @park.save
      		redirect_to current_user
    	else
      		redirect_back fallback_location: park_path
    	end
  	end

	def show
		@park = Park.find(params[:id])
		@comments= ParkComment.all

        @comment = ParkComment.new(:user_id => current_user.id)
    end

    def destroy
    	@park = Park.find(params[:id])
        if @park.destroy
          redirect_to current_user
        else
            render plain: "couldn't delete"
        end
    end

	private

	def parks_params
		params.require(:park).permit(:name, :location,:latitude,:longitude,:user_id)
	end
end
