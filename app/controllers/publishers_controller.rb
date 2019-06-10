class PublishersController < ApplicationController

  get '/publishers' do
    @books = current_book.publishers
    erb :'books/publishers'
  end
end
