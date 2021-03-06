class ReadersController < ApplicationController

  get '/readers' do
    @reader = Reader.all
    erb :'readers/index'
  end

  get '/signup' do
    redirect '/books' if logged_in?
    erb :'readers/signup'
  end

  post '/signup' do
    if params[:name] == "" || params[:email] == "" || params[:password] ==""
      redirect "/signup"
    else
      @reader = Reader.new(name: params[:name], email: params[:email], password: params[:password])
      if @reader.save
        session[:reader_id] = @reader.id
        redirect '/books'
      else
        redirect "/signup"
      end
    end
  end

  get '/login' do
    redirect '/books' if logged_in?
    erb :'readers/login'
  end

  post '/login' do
    @reader = Reader.find_by(:name => params[:name])
    if @reader && @reader.authenticate(params[:password])
      session[:reader_id] = @reader.id
      redirect '/books'
    else
      redirect '/signup'
    end
  end
  get '/logout' do
    redirect_if_not_logged_in
    session.clear
    redirect '/login'
  end
end
