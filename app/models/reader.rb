class Reader < ActiveRecord::Base
  has_many :books_reader
  has_many :books, through: :books_reader
  has_many :publishers, through: :books
  has_secure_password
  validates :name, uniqueness: true

end
