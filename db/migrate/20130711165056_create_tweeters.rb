class CreateTweeters < ActiveRecord::Migration
  def change
    create_table :tweeters do |tweeter|
      tweeter.integer :user_id
      tweeter.integer :channel_id
      tweeter.timestamps
    end
  end
end
