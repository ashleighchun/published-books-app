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
    redirect_if_not_logged_in
    error_check
    @publisher = Publisher.find_by_id(params[:id])
    @books = current_reader.books.where("publisher_id = '#{params[:id]}'")
    erb :'books/show'
  end

end
