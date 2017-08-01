class CreateParkComments < ActiveRecord::Migration[5.1]
  def change
    create_table :park_comments do |t|
        t.string :content
        t.belongs_to :user, foreign_key: true, index: true
        t.belongs_to :park, foreign_key: true, index: true
        t.timestamp
    end
  end
end
