class BooksController < ApplicationController

  get '/books' do
    redirect '/login' if !logged_in?
    if session[:reader_id]
      @reader = current_reader
      @books = current_reader.books
      erb :'books/index'
    end

  end


  get '/books/new' do #-------this has to come first because it prevents a false match. when it gets a request it looks for a route starting from the top and going down. if it gets to id before new it will assume new is the id and will go into show instead of new
    redirect '/login' if !logged_in?
    erb :'books/new'
  end

  post '/books' do
    redirect '/login' if !logged_in?
    if params[:title] == ""
      redirect to "/books/new"
    else
      @book = current_reader.books.build(title: params[:title])
      if @book.save
        if publisher
        
        #if publisher exists then connect it to this book, publishers book need to include this book and the book needs to know this publishers
        #if publisher doesnt exist make the publisher and make the connections
        #use association collections as much as possible
        redirect to "/books/#{@book.id}"
      else
        redirect to "/books/new"
      end
    end
  end

  get '/books/:id' do
    redirect '/login' if !logged_in?
    @book = Book.find_by_id(params[:id])
    erb :'books/show'
  end

  get '/books/:id/edit' do
    redirect '/login' if !logged_in?
    @book = Book.find_by_id(params[:id])
    if @book && @book.reader == current_reader
      erb :'books/edit'
    else
      redirect to '/books'
    end
  end

  patch '/books/:id' do
    redirect '/login' if !logged_in?
    if params[:title] == ""
      redirect to "/books/#{params[:id]}/edit"
    else
      @book = Book.find_by_id(params[:id])
      if @book && @book.reader == current_reader
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
