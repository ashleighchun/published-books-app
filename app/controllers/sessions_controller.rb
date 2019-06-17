class SessionsController<ApplicationController
  get '/sessions/login' do
    if logged_in?
      redirect to '/welcome'
    else
      erb :'sessions/login'
    end
  end

  post '/sessions/login' do
    user = User.find_by(name: params[:name])

    if reader && reader.authenticate(params[:password])
      session[:reader_id] = reader.id
      redirect to '/books'
    else
      redirect to '/readers/signup'
    end
  end

  get '/sessions/logout' do
    session.clear
    redirect to '/'
  end
end
