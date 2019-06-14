class Book < ActiveRecord::Base
  has_many :books_reader
  has_many :readers, through: :books_reader
  belongs_to :publisher
end
