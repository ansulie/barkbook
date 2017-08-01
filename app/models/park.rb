class Park < ApplicationRecord
  belongs_to :user

  has_many :park_comments, :dependent => :destroy

end
