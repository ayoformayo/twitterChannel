get '/create' do
  @user = User.find(session[:user_id])
  erb :create_page
end

post '/create' do
  p params
  @user = User.find(session[:user_id])
  @channel = Channel.create(user_id: @user.id, name: params[:input][:channel])
  params[:input][:handle].each do |handle|
    #need find or create by
    @new_user = User.find_or_create_by_username(:username => handle)
    @new_user.fetch_tweets!
    Tweeter.create(user_id: @new_user.id, channel_id: @channel.id)
  end

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
@channel.users.each {|user| user.tweets.destroy_all}
@channel.users.destroy_all
 params[:input][:handle].each do |handle|
    #need find or create by
    @new_user = User.find_or_create_by_username(:username => handle)
    @new_user.fetch_tweets!
    Tweeter.create(user_id: @new_user.id, channel_id: @channel.id)
  end


redirect '/my_page'
end

post '/delete' do
  @channel = Channel.find(params[:id].to_i)
  @channel.destroy
  redirect '/my_page'
end
