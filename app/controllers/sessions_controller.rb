class SessionsController<ApplicationController
  get '/login' do
    error_check
    erb :"sessions/login"
  end

  post '/login' do
    user = User.find_by(name: params[:name])

    if reader && reader.authenticate(params[:password])
      session[:reader_id] = reader.id
      redirect to '/books'
    elsif reader
      session[:errors] = ["Please enter a valid password"]
      redirect "/login"
    else
      session[:errors] = ["Please enter a valid username"]
      redirect "/login"
    end
  end

  get '/logout' do
    session.clear
    redirect to '/login'
  end
end
