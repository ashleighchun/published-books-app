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
    redirect_if_not_logged_in
    @publishers = Publisher.all
    erb :'books/new'
  end

  get '/books/:id' do
    redirect_if_not_logged_in
    @book = Book.find_by_id(params[:id])
    erb :'books/show'
  end

  post '/books' do
    redirect_if_not_logged_in
    if params[:book][:title] == ""
      redirect to "/books/new"
    else
      book = current_reader.books.build(params[:book])
      book.publisher = Publisher.find_or_create_by(name: params[:publisher][:name]) if !params[:publisher][:name].empty?
      book.save
      redirect to "/books"
    end
  end



  get '/books/:id/edit' do
    redirect_if_not_logged_in
    @book = current_reader.books.find_by_id(params[:id])
    @publishers = current_reader.publishers
    redirect to '/books' if !@book
    erb :"books/edit"
  end


  patch '/books/:id' do
    redirect_if_not_logged_in
    if params[:title] == ""
      redirect to "/books/#{params[:id]}/edit"
    else
      @book = Book.find_by_id(params[:id])
      @book.update(params["book"])
      if !params["publisher"]["name"].empty?
        publisher = Publisher.find_or_create_by(name: params["publisher"]["name"])
        @book.update(publisher: publisher)
      end
      redirect to "books/#{@book.id}"
    end
  end

  delete '/books/:id/delete' do
    redirect_if_not_logged_in
    @book = Book.find_by_id(params[:id])
    @book.delete
    redirect to '/books'
  end
end
