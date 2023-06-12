class Book
  attr_reader :id, :destination, :forecast, :total_books_found, :books

  def initialize(data, location, forecast)
    @id = nil
    @destination = location
    @forecast = format_forecast(forecast)
    @total_books_found = data[:num_found]
    @books = format_books(data[:docs])
  end

  def format_forecast(forecast)
    {
      summary: forecast.current_weather[:conditions],
      temperature: "#{forecast.current_weather[:temperature].to_i} F"
    }
  end

  def format_books(data)
    data.map do |book|
      {
        isbn: book[:isbn],
        title: book[:title],
        publisher: book[:publisher]
      }
    end
  end
end