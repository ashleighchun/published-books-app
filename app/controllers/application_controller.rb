require './config/environment'

class ApplicationController < Sinatra::Base


  configure do
    set :public_folder, 'public'
    set :views, 'app/views'
    enable :sessions
    set :session_secret, "secret"

  end

  get "/" do
    erb :home
  end

  helpers do
    def logged_in?
      !!session[:reader_id]
    end

    def current_reader
      @reader ||= Reader.find_by_id(session[:reader_id])
    end

    def redirect_if_not_logged_in
      redirect "/login" if !logged_in?
    end

    def error_check
     @errors = session.delete(:errors)
    end
    def log_errors(obj)
      session[:errors] = obj.errors.to_a if obj.errors.any?
    end
  end
end
