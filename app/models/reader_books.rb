class ReaderBooks < ActiveRecord::Base
  belongs_to :reader
  belongs_to :books
end 
