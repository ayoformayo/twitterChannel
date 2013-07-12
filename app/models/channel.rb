class Channel < ActiveRecord::Base
  belongs_to :user
  has_many :tweeters
  has_many :users, through: :tweeters
  has_many :tweets, through: :users
end
