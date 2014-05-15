require 'set'
require 'find'
require_relative 'lib/reader.rb'

class SearchEngine
  include Reader
  attr_accessor :density_hash, :books, :result_array
  # call read_books and set up your data structures to make it easier when you call search
  def initialize(folder)
    @density_hash = {}
    read_books(folder)
    @result_array = []
  end

   def read_books(folder)
      # read the module to see how to read all books. The folder is called "search"
     @books = read_all_books(folder)
   end

  def search(query) # Implement this search, return an array of book names in order of relatedness
    @books.each do |k,v|
      if k.downcase.include?(query)
        @result_array.push(k.to_s)
      end
      @result_array
    end

    @books.each do |k,v|
      density = v.count(query).to_f/ v.length.to_f
      @density_hash[k] = density
      
    end
     result = @density_hash.sort_by{|k, v| v}.reverse.map(&:first)
     result.each do |titles| 
      if @result_array.include?(titles) == false
        @result_array.push(titles)
      end
    end
    @result_array

  end

end
