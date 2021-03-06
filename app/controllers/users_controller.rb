require 'pry'

class UsersController < ApplicationController
  
  get '/signup' do 
    if !logged_in?
		  erb :'users/create_user'
		else 
		  redirect to "/users/show"
		end
  end
  
  post '/signup' do 
	  if params[:username] == "" || params[:email] == "" || params[:password] == ""
	    redirect to '/signup'
	  else
	    @user = User.new(username: params[:username], email: params[:email], password: params[:password])
	    @user.save
      session[:user_id] = @user.id
      redirect to "/users/show"
    end
	end
	
	get "/login" do
	  if !logged_in?
		  erb :'users/login'
		else
      redirect to "/users/show"
    end
	end
	
	post '/login' do 
	  user = User.find_by(:username => params[:username])
 
    if user && user.authenticate(params[:password])
      session[:user_id] = user.id 
      redirect to "/users/show"
    else 
	    redirect to '/signup'
    end
	end
	
	get '/users/:slug' do 
    if logged_in?
      @user = User.find_by_slug(:slug)
      erb :'/users/show'
    else
      redirect to '/login'
    end
  end
  
  get "/logout" do
	  if logged_in?
		  session.clear
		  redirect to "/login"
		else 
		  redirect to '/'
		end
	end
	
	delete '/users/:id/delete' do
    if logged_in?
      @user = User.find_by_id(params[:id])
      if @user && @user == current_user 
        @user.delete
      end
        redirect to "/"
    else
      redirect to '/login'
    end
  end
  
end