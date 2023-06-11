class MapquestService
  def geocode(location)
    get_url("/geocoding/v1/address?location=#{location}")
  end

  def conn
    Faraday.new(url: 'http://www.mapquestapi.com') do |f|
      f.params['key'] = ENV['MAPQUEST_API_KEY']
    end
  end

  def get_url(url)
    response = conn.get(url)
    JSON.parse(response.body, symbolize_names: true)
  end
end