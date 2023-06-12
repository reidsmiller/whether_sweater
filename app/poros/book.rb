class Book
  attr_reader :id, :type, :destination, :forecast, :total_books_found, :books

  def initialize(data, location, forecast)
    @id = nil
    @type = 'books'
    @destination = location
    @forecast = format_forecast(forecast)
    @total_books_found = data[:num_found]
    @books = format_books(data[:docs])
  end

  def format_forecast(data)
    {
      summary: data[:current_weather][:conditions],
      temperature: data[:current_weather][:temperature]
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