class SessionsController<ApplicationController

  get '/login' do
    redirect '/books' if logged_in?
    erb :'sessions/login'
  end

  post '/login' do
    @reader = Reader.find_by(:name => params[:name])
    if reader && reader.authenticate(params[:password])
      session[:reader_id] = reader.id
      redirect '/books/index'
    else
      redirect '/login' #should this redirect to login?
    end
  end
  get '/logout' do
    session.clear
    redirect '/' 
  end
end
