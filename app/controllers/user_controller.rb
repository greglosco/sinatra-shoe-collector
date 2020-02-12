class UserController < ApplicationController
  
  get '/signup' do 
    if !logged_in?
		  erb :'users/create_user'
		else 
		  redirect to "/shoes"
		end
  end
  
end