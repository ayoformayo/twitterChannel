get '/' do
  @user = User.find(session[:user_id]) if session[:user_id]
  # @fake_tweet = Faker::Company.bs
  erb :index
end

get '/sign_in' do
  # the `request_token` method is defined in `app/helpers/oauth.rb`
  redirect request_token.authorize_url
end

get '/sign_out' do
  session.clear
  redirect '/'
end

get '/auth' do
  # the `request_token` method is defined in `app/helpers/oauth.rb`
  @access_token = request_token.get_access_token(:oauth_verifier => params[:oauth_verifier])
  # our request token is only valid until we use it to get an access token, so let's delete it from our session

  session.delete(:request_token)

  # at this point in the code is where you'll need to create your user account and store the access token
  @user = User.find_or_create_by_username(oauth_token:@access_token.token, oauth_secret: @access_token.secret, username: @access_token.params[:screen_name])
  p @user
  session[:user_id] = @user.id
  redirect '/my_page'
end

get '/my_page' do
  @user = User.find(session[:user_id])
  erb :mypage
end

post '/' do
  @user = User.find(params['user'])
  job_id = @user.tweet(params['tweetText'], params['time'])
  return job_id
end


get '/status/:job_id' do
  id = params[:job_id]
  content_type :json
  {finished: job_is_complete(id), id: id}.to_json   
end
