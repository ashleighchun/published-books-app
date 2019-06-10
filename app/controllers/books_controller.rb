class BooksController < ApplicationController

  get '/books' do
    #redirect '/login' if !logged_in?
    @books = current_reader.books
    erb :'books/books'
  end
end
