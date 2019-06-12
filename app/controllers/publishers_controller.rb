class PublishersController < ApplicationController

  get '/publishers' do
    if logged_in?
      @books = current_book.publishers.uniq
      erb :'books/publishers'
    else
      redirect '/login'
    end
  end

  get '/publishers/:id' do
    if logged_in?
      @publisher = Publisher.find_by_id(params[:id])
      @books = @publisher.books.select { |dream| dream.user_id == current_user.id}
      erb :'books/show'
    else
      redirect '/login'
    end 
  end
end
