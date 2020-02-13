require 'pry'

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
      if params[:name] == "" || params[:brand] == "" || params[:color] == ""
        redirect to '/shoes/new'
      else 
        @shoe = current_user.shoes.new(name: params[:name], brand: params[:brand], color: params[:color])
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
      @shoe = Shoe.find_by_id(params[:id])
      erb :'/shoes/show_shoe'
    else
      redirect to '/login'
    end
  end
  
  get '/shoes/:id/edit' do 
    if logged_in?
      @shoe = Shoe.find_by_id(params[:id])
      if @shoe && @shoe.user == current_user
        erb :'/shoes/edit_shoe'
      else 
        redirect to '/shoes'
      end
    else
      redirect to '/login'
    end
  end
  
  patch '/shoes/:id' do 
    if logged_in?
      if params[:name] == "" || params[:brand] == "" || params[:color] == ""
        redirect to "/shoes/#{params[:id]}/edit"
      else
        @shoe = Shoe.find_by(params[:id])
        if @shoe && @shoe.user == current_user
          if @shoe.update(name: params[:name], brand: params[:brand], color: params[:color])
            redirect to "/shoes/#{@shoe.id}"
          else
            redirect to "/shoes/#{@shoe.id}/edit"
          end
        else 
          redirect to "/shoes"
        end
      end
    else
      redirect to '/login'
    end
  end
  
  delete '/shoes/:id/delete' do
    if logged_in?
      @shoe = Shoe.find_by(params[:id])
      if @shoe && @shoe.user == current_user 
        @shoe.delete
      end
        redirect to "/shoes"
    else
       redirect to '/login'
    end
  end
  
end