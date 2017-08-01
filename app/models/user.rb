class User < ApplicationRecord
    has_many :friendships
    has_many :friends, through: :friendships
    has_many :inverse_friendships, class_name: 'Friendship', foreign_key: 'friend_id'
    has_many :inverse_friends, through: :inverse_friendships, source: :user

    has_many :parks, dependent: :destroy
    has_many :events, dependent: :destroy
    has_many :park_comments, dependent: :destroy
    has_many :event_comments, dependent: :destroy

    has_secure_password
    validates :password_digest, presence: true, confirmation: true
    validates :email, presence: true, uniqueness: true, format: {
        with: /\A[^@]+@([^@\.]+\.)+[^@\.]+\z/
    }
    validates :name, presence: true

    geocoded_by :address
    after_validation :geocode
end
