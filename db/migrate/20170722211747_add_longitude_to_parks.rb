class AddLongitudeToParks < ActiveRecord::Migration[5.1]
  def change
  	 add_column :parks, :longitude, :integer, :null => true
  end
end
