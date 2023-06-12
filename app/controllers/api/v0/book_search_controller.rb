class Api::V0::BookSearchController < ApplicationController
  def index
    forecast = ForecastFacade.new(params[:location]).forecast
    books = BookFacade.new(params, forecast).books
    render json: BookSerializer.new(books)
  end
end