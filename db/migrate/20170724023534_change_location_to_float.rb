class ChangeLocationToFloat < ActiveRecord::Migration[5.1]
    def change
        change_column :parks, :longitude, :float, :null => true
        change_column :parks, :latitude, :float, :null => true
    end
end
