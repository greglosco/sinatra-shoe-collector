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
  
  post '/shoes' do 
    if logged_in?
      if params[:content] == ""
        redirect to '/shoes/new'
      else 
        @shoe = current_user.shoes.build(name: params[:name], brand: params[:brand], color: params[:color])
        if @shoe.save
          redirect to "/shoes/#{@shoe.id}"
        else
          redirect to '/shoes/new'
        end
      end
    else
      redirect to '/login'
    end
  end
  
  get '/shoes/:id' do
    if logged_in?
      @shoe = Shoe.find_by(params[:id])
      erb :'/shoes/show_shoe'
    else
      redirect to '/login'
    end
  end
  
end