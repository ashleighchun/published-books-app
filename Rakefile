ENV["SINATRA_ENV"] ||= "development"

require_relative './config/environment'
require 'sinatra/activerecord/rake'

task :console do #allows you to run rake console, db testing
  Pry.start
end
