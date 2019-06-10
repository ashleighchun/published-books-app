class ReadersController < ApplicationController

  get 'readers/:slug' do
    @reader = Reader.find_by_slug(params[:slug])
    erb :'users/show'
  end
end 
