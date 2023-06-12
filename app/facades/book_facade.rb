class BookFacade
  class GeolocationError < StandardError; end

  def initialize(params, forecast)
    @location = params[:location]
    @quantity = params[:quantity]
    @forecast = forecast
  end

  def books
    Book.new(book_data, @location, @forecast)
  end

  private

  def service
    @_service ||= BookService.new
  end

  def book_data
    @_book_data ||= service.books(@location, @quantity)
  end
end