class BooksController < ApplicationController

  get '/books' do
    redirect '/login' if !logged_in?
    @books = Book.all
    erb :'books/books'
  end


  get '/books/new' do
      redirect '/login' if !logged_in?
      erb :'books/new'
    end

    post '/books' do
      puts params
      redirect '/login' if !logged_in?
      if params[:title] == ""
        redirect to "/books/new"
      else
        @book = current_reader.books.build(title: params[:title], publisher: params[:publisher])
        if @book.save
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
