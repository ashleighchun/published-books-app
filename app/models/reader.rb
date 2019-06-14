class Reader < ActiveRecord::Base
  has_many :books_reader
  has_many :books, through: :books_reader
  has_many :publishers, through: :books
  has_secure_password

  def slug
    self.name.strip.gsub(' ', '-').gsub(/[^\w-]/, '')
  end

  def self.find_by_slug(slug)
    unslug = slug.gsub('-', ' ')
    User.find_by(name: unslug)
  end
end
