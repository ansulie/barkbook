class CreateEvents < ActiveRecord::Migration[5.1]
  def change
    create_table :events do |t|
        t.string :name
        t.string :location
        t.string :event_date
        t.belongs_to :user, foreign_key: true, index: true
    end
  end
end
