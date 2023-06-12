class Api::V0::BookSearchController < ApplicationController
  def index
    books = BookFacade.new(params).books
    render json: BookSerializer.new(books)
  end
end