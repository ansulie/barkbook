class CreateEventComments < ActiveRecord::Migration[5.1]
  def change
    create_table :event_comments do |t|
        t.string :content
        t.belongs_to :user, foreign_key: true, index: true
        t.belongs_to :event, foreign_key: true, index: true
        t.timestamp
    end
  end
end
