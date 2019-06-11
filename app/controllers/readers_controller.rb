class ReadersController < ApplicationController

  get 'readers/:slug' do
    @reader = Reader.find_by_slug(params[:slug])
    erb :'users/show'
  end
  get '/signup' do
     if logged_in?
       redirect '/tweets'
     else
       erb :'users/signup'
     end
   end

   post '/signup' do
    if params[:name] == "" || params[:email] == "" || params[:password] ==""
      redirect "/signup"
    else
      @reader = Reader.create(name: params[:name], email: params[:email], password: params[:password])
      session[:reader_id] = @reader.id
      redirect '/books'
    end
  end

  get '/login' do
    redirect '/books' if logged_in?
    erb :'readers/login'
  end

  post '/login' do
    @reader = reader.find_by(:name => params[:name])
    if @reader && @reader.authenticate(params[:password])
      session[:reader_id] = @reader.id
      redirect '/books'
    else
      redirect '/signup'
    end
  end

  get '/logout' do
    redirect '/books' if !logged_in?
    session.clear
    redirect '/login'
  end
end
