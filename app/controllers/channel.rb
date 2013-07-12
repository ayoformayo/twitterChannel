get '/create' do
  @user = User.find(session[:user_id])
  erb :create_page
end

post '/create' do
  p params
  @user = User.find(session[:user_id])
  @channel = Channel.create(user_id: @user.id, name: params[:input][:channel])
  @user1 = User.create(:username => params[:input][:handle1])
  @user2 = User.create(:username => params[:input][:handle2])
  @user3 = User.create(:username => params[:input][:handle3])
  @user1.fetch_tweets!
  @user2.fetch_tweets!
  @user3.fetch_tweets!
  Tweeter.create(user_id: @user1.id, channel_id: @channel.id)
  Tweeter.create(user_id: @user2.id, channel_id: @channel.id)
  Tweeter.create(user_id: @user3.id, channel_id: @channel.id)
  redirect '/my_page'
end

get '/channel/:channel_id' do
@user = User.find(session[:user_id])
@channel = Channel.find(params[:channel_id].to_i)
erb :my_channel
end

get '/edit/:channel_id' do
  @channel = Channel.find(params[:channel_id])
erb :edit_page
end

post '/edit' do
@channel = Channel.find(params[:input][:channel_id])
Channel.update(@channel.id, name: params[:input][:channel] )

  @user1 = User.create(:username => params[:input][:handle1])
  @user2 = User.create(:username => params[:input][:handle2])
  @user3 = User.create(:username => params[:input][:handle3])
  @user1.fetch_tweets!
  @user2.fetch_tweets!
  @user3.fetch_tweets!
  Tweeter.create(user_id: @user1.id, channel_id: @channel.id)
  Tweeter.create(user_id: @user2.id, channel_id: @channel.id)
  Tweeter.create(user_id: @user3.id, channel_id: @channel.id)

redirect '/my_page'
end
