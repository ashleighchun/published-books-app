class ReadersController < ApplicationController

  get '/readers' do
    @reader = Reader.all
    erb :'readers/index'
  end

  get '/signup' do
     if logged_in?
       redirect '/books'
     else
       erb :'readers/signup'
     end
   end

   post '/signup' do
    if params[:name] == "" || params[:email] == "" || params[:password] ==""
      redirect "/signup"
    else
      @reader = Reader.create(name: params[:name], email: params[:email], password: params[:password])
      session[:reader_id] = reader.id
      redirect '/books'
    end
  end

  get '/login' do
    redirect '/books' if logged_in?
    erb :login
  end

  post '/login' do
    reader = Reader.find_by(:name => params[:name])
    if reader && reader.authenticate(params[:password])
      session["reader_id"] = reader.id
      redirect '/books'
    else
      redirect '/login'
    end
  end
  get '/logout' do
    session.clear
    redirect '/'
  end
end
