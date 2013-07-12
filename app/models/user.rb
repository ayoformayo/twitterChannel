class User < ActiveRecord::Base
  has_many :tweets
  has_many :channels
  has_many :tweeters



  def fetch_tweets!
    tweets = Twitter.user_timeline(self.username, :count => 10)
    self.tweets = tweets.map { |t| Tweet.create(:text => t.text, 
                                                :user_id => self.id)}
  end


  def tweet(text,delay=0)
    delay = delay.to_i
    tweet = tweets.create!(:text => text)
    TweetWorker.perform_in(delay.seconds, tweet.id)
    # TweetWorker.perform_async(tweet.id)
  end

  def twitter
    @twitter ||= Twitter::Client.new(oauth_token: self.oauth_token, oauth_token_secret: self.oauth_secret)
  end
end
