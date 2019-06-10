class Reader < ActiveRecord::Base
  has_many :reader_books
  has_many :books, through: :reader_books
end 
