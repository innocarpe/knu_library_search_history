class BookSearchHistory < ActiveRecord::Base
  attr_accessible :book_name, :search_count
end
