class ShoesController < ApplicationController 
  
   get '/shoes' do 
    if logged_in?
      @shoes = Shoe.all
      erb :'/shoes/shoes'
    else
      redirect to '/login'
    end
  end
  
  get '/shoes/new' do 
    if logged_in?
      erb :'/shoes/new'
    else
      redirect to '/login'
    end
  end
  
end