class PublishersController < ApplicationController

  get '/publishers' do
    redirect_if_not_logged_in
    @publishers = current_reader.publishers
    erb :'publishers/index'
  end

  get '/publishers/:id' do
    redirect_if_not_logged_in
    @publisher = Publisher.find_by_id(params[:id])
    @books = current_reader.books.where("publisher_id = '#{params[:id]}'")
    erb :'publishers/show'
  end
end
