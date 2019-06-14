class PublishersController < ApplicationController

  get '/publishers' do
    if logged_in?
      @publishers = current_reader.publishers
      erb :'publishers/index'
    else
      redirect '/login'
    end
  end

  get '/publishers/:id' do
    if logged_in?

      @publisher = Publisher.find_by_id(params[:id])
      @books = current_reader.books.where("publisher_id = '#{params[:id]}'")

      erb :'books/show'
    else
      redirect '/login'
    end
  end
end
