class ForecastFacade
  class GeolocationError < StandardError; end

  def initialize(location)
    @location = location
  end

  def geolocation
    raise GeolocationError, geolocation_data[:info][:messages].first if geolocation_data[:info][:statuscode] == 400

    @_geolocation ||= Geolocation.new(geolocation_data)
  end

  def forecast
    Forecast.new(weather_data)
  end

  private

  def geolocation_service
    @_geolocation_service ||= MapquestService.new
  end

  def weather_service
    @_weather_service ||= WeatherApiService.new
  end

  def geolocation_data
    @_geolocation_data ||= geolocation_service.geocode(@location)
  end

  def weather_data
    @_weather_data ||= weather_service.weather(geolocation.lat, geolocation.lng)
  end
end