class BooksController < ApplicationController

  get '/books' do

    if logged_in?
      @reader = current_reader
      @books = current_reader.books
      erb :'books/index'
    else
      puts "You are not logged in."
      redirect to "/login"
    end
  end


  get '/books/new' do  #-------new first prevents a false match. when it gets a request it looks for a route starting from the top and going down. if it gets to id before new it will assume new is the id and will go into show instead of new
    redirect '/login' if !logged_in?
    erb :'books/new'
  end

  get '/books/:id' do
    redirect '/login' if !logged_in?
    @book = Book.find_by_id(params[:id])
    erb :'books/show'
  end

  post '/books' do #confirmed correct
    redirect '/login' if !logged_in?
    if params[:title] == ""
      redirect to "/books/new"
    else
      book = current_reader.books.build(title: params[:title])
      book.publisher = Publisher.find_or_create_by(name: params[:publisher])
      book.save
      redirect to "/books"
    end
  end



  get '/books/:id/edit' do
    redirect_if_not_logged_in
    @book = current_reader.books.find_by_id(params[:id])
    redirect to '/books' if !@book
    erb :"books/edit"
  end


  patch '/books/:id' do
    #book = current_reader.books.find_by_id(params[:id])
    #book.update(params[:book])
    #log_errors(book)
    #redirect "/books/#{book.id}"
    redirect '/login' if !logged_in?
    if params[:title] == ""
      redirect to "/books/#{params[:id]}/edit"
    else
      @book = Book.find_by_id(params[:id])
      if @book && @book.readers == current_reader
        if @book.update(title: params[:title], publisher: params[:publisher])
          redirect to "/books/#{@book.id}"
        else
          redirect to "/books/#{@book.id}/edit"
        end
      else
        redirect to '/books'
      end
    end
  end

  delete '/books/:id/delete' do
    redirect '/login' if !logged_in?
    @book = Book.find_by_id(params[:id])
    if @book && @book.reader == current_reader
      @book.delete
    end
    redirect to '/books'
  end
end
