# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)


EventComment.delete_all
ParkComment.delete_all
Event.delete_all
Park.delete_all
Friendship.delete_all
User.delete_all

user = User.create(
    :name => 'john',
    :email => "test@test.com",
    :password_digest => "$2a$10$pJiFj1xUfIHyKjsnU.ZkFuwQ4y7ol7L9tYP83IEq.lAsWvM5t/2j2",
    :latitude => '40.7127837',
    :longitude => '-74.0059413',
    :address => "New York"
)
user2 = User.create(
    :name => 'john2',
    :email => "2test@test.com",
    :password_digest => "$2a$10$pJiFj1xUfIHyKjsnU.ZkFuwQ4y7ol7L9tYP83IEq.lAsWvM5t/2j2",
    :latitude => '40.7127837',
    :longitude => '-74.0059413',
    :address => "New York"
)

friends_w_two_not_one = User.create(
    :name => 'friends_w_two_not_one',
    :email => "partfriends@partfriends.com",
    :password_digest => "$2a$10$pJiFj1xUfIHyKjsnU.ZkFuwQ4y7ol7L9tYP83IEq.lAsWvM5t/2j2",
    :latitude => '40.7127837',
    :longitude => '-74.0059413',
    :address => "New York"
)

user3 = User.create(
    :name => 'nofriends',
    :email => "nofriends@nofriends.com",
    :password_digest => "$2a$10$pJiFj1xUfIHyKjsnU.ZkFuwQ4y7ol7L9tYP83IEq.lAsWvM5t/2j2",
    :latitude => '40.7127837',
    :longitude => '-74.0059413',
    :address => "New York"
)

#just build each friendship both ways. Otherwise you have to use the inverse_friendship method as well, which is annoying, and it doesn't have access
#to all the same methods (.events) that .friends does. Not sure why, but not worth agonizing over.
friendship = user.friendships.build(:friend_id => user2[:id])
friendship.save
friendship = user2.friendships.build(:friend_id => user[:id])
friendship.save

friendship = user2.friendships.build(:friend_id => friends_w_two_not_one[:id])
friendship.save
friendship = friends_w_two_not_one.friendships.build(:friend_id => user2[:id])
friendship.save

park = Park.create(:name => 'dogpark', :location => 'def not hell', :user_id => user[:id])
event = Event.create(:name => 'puppers and puppettes meetup', :location => 'the ritz', :user_id => user[:id])
event2 = Event.create(:name => 'user1 second event', :location => 'th2e ritz', :user_id => user[:id])
event3 = Event.create(:name => 'user2 event', :location => 'th3e ritz', :user_id => user2[:id])
event4 = Event.create(:name => "partfriend's event", :location => 'partfriend event location', :user_id => friends_w_two_not_one[:id])

meetup_comment = EventComment.create(:content => 'what a lovely event idea judith', :user_id => user[:id], :event_id => event[:id])
me2etup_comment = EventComment.create(:content => 'wha2t a lovely e2vent idea ju2dith', :user_id => user[:id], :event_id => event[:id])

location_comment = ParkComment.create(:content => 'what a lovely location idea judith', :user_id => user[:id], :park_id => park[:id])
loc2ation_comment = ParkComment.create(:content => 'wha2t a lovely lo2c2a2tion idea ju2dith', :user_id => user[:id], :park_id => park[:id])


# query stash:
# it's
# EventComment.all
#
# BUT, ANNOYINGLY:
#
# Event.first.event_comments
# or
# User.first.event_comments
#
# and for friends connections:
#
# User.first.friends
# or
# Friendship.first
