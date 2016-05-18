# Homepage (Root path)
get '/' do
  erb :'index'
end

get '/songs' do
  @songs = Song.all
  erb :'songs/index'
end

get '/songs/new' do
  @song = Song.new
  erb :'songs/new'
end

get '/songs/:id' do
  @song = Song.find params[:id]
  erb :'songs/show'
end

post '/songs' do
  @song = Song.new(
    title:   params[:title],
    url: params[:url],
    author:  params[:author]
  )
  if @song.save
    redirect '/songs'
  else
    erb :'songs/new'
  end
end


get '/' do
  redirect '/songs'
end

get '/login' do
  erb :login
end

helpers do
  def current_user
    User.find(session[:user_id]) if session[:user_id]
  end
end

get '/' do
  erb :index
end

post '/login' do
  @user = User.find_by_email(params[:email])
  if @user && @user.try(:authenticate, params[:password])
    session[:user_id] = @user.id
    redirect '/'
  else
    @error = "You could not log in!"
    erb :index
  end

end

get '/logout' do
  session[:user_id] = nil
  redirect '/'
end













get '/register' do
  erb :register 
end

post '/register' do 
  # if params[:password] == params[:password_confirmation]
    u = User.create(email: params[:email], password: params[:password])
    session[:id] = u.id
    redirect '/'
end

# def current_user
#   # if the user has a remember cookie set...automatically log them in
#   if cookies.has_key? :remember_me
#     user = User.find_by_remember_token(cookies[:remember_me])
#     return user if user
#   end

#   if session.has_key?(:user_session)
#     user = User.find_by_login_token(session[:user_session])
#   else
#     nil
#   end
# end

# get '/songs' do
#   if current_user
#     erb :secure
#   else
#     redirect '/songs'
#   end
# end

# post '/session' do
#   @user = User.find_by_email(params[:email])
#   if @user && @user.authenticate(params[:password])
#     session[:user_session] = SecureRandom.hex
#     @user.login_token = session[:user_session]

#     if params.has_key?('remember_me') && params[:remember_me] == 'true'

#       if @user.remember_token
#         response.set_cookie :remember_me, {value: @user.remember_token, max_age: "2592000" }
#       else
#         response.set_cookie :remember_me, {value: SecureRandom.hex, max_age: "2592000" }
#         @user.remember_token = cookies[:remember_me]
#       end
#     end

#     @user.save
#     redirect '/songs'
#   else
#     erb :login
#   end
# end