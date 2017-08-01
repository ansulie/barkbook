class CreateParks < ActiveRecord::Migration[5.1]
  def change
    create_table :parks do |t|
        t.string :name
        t.string :location
        t.belongs_to :user, foreign_key: true, index: true
        t.timestamps
    end
  end
end
