require "sinatra"
require "sinatra/activerecord"
require "./models"

enable :sessions
set :database, "sqlite3:database.sqlite3"

get "/" do 
  erb :index
end

get "/blog" do
  @posts = Post.all
  erb :blog
end

get "/myprofile" do
  erb :myprofile
end

get "/profiles" do
  @users = User.all 
  erb :profiles
end

get "/login" do
  erb :login
end

get "/signup" do
  erb :signup
end

get '/logout/?' do
  session[:user_id] = nil
  "You are now logged out."
end

get '/delete_account' do
  erb :delete_account
end

get '/account_deleted' do
  erb :account_deleted
end


def current_user
  if session[:user_id]
    @current_user = User.find(session[:user_id])
  end
end

# WHEN USERS POST FORMS
post '/updateprofile' do
  #code here to update the profile
  @profile = current_user.profile
  @profile.fname = params[:fname]
  @profile.lname = params[:lname]
  @profile.location = params[:location]
  @profile.bio = params[:bio]
  @profile.save
  erb :updateprofile
end

post '/signup' do
  User.create(
    username: params[:username],
    password: params[:password],
  )
  "You are now signed up. Please go to the Login page to Login."
end

# Sign-in button/activate session
post "/login" do
  @user = User.where(username: params[:username]).first
  if @user && @user.password == params[:password]
    session[:user_id] = @user.id
    "You are now logged in."
  else
    "Your password was incorrect."
  end
end

# When user clicks the upload_post button
post "/blog" do
  Post.create(:subject => params[:subject], :content => params[:content])
  @posts = Post.all
  erb :blog
end

post '/myprofile' do
  Post.create(message: params[:message], user_id: current_user.id)
  redirect 'myprofile'
end

post '/createprofile' do
  Profile.create(
    fname: params[:fname],
    lname: params[:lname],
    location: params[:location],
    bio: params[:bio],
  )
  redirect '/myprofile'
end

post '/updateprofile' do
  redirect '/myprofile'
end

post '/delete_account' do
  User.delete(
    username: params[:username],
    password: params[:password],
  )
  "You have deleted your account."
  "Feel free to make a new account!"
end
