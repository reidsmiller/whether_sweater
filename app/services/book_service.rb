class BookService
  def books(location, quantity)
    get_url("/search.json?title=#{location}&limit=#{quantity}")
  end

  private

  def conn
    Faraday.new(url: 'https://openlibrary.org')
  end

  def get_url(url)
    response = conn.get(url)
    JSON.parse(response.body, symbolize_names: true)
  end
end