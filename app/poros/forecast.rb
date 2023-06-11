class Forecast
  attr_reader :id, :type, :current_weather, :daily_weather, :hourly_weather

  def initialize(data)
    @id = nil
    @type = 'forecast'
    @current_weather = format_current_weather(data[:current])
    @daily_weather = format_daily_weather(data[:forecast][:forecastday])
    @hourly_weather = format_hourly_weather(data[:forecast][:forecastday])
  end

  def format_current_weather(data)
    {
      last_updated: data[:last_updated],
      temperature: data[:temp_f],
      feels_like: data[:feelslike_f],
      humidity: data[:humidity],
      uvi: data[:uv],
      visibility: data[:vis_miles].to_i,
      conditions: data[:condition][:text],
      icon: data[:condition][:icon]
    }
  end

  def format_daily_weather(data)
    data.map do |day|
      {
        date: day[:date],
        sunrise: day[:astro][:sunrise],
        sunset: day[:astro][:sunset],
        max_temp: day[:day][:maxtemp_f],
        min_temp: day[:day][:mintemp_f],
        conditions: day[:day][:condition][:text],
        icon: day[:day][:condition][:icon]
      }
    end
  end

  def format_hourly_weather(data)
    data[0][:hour].map do |hour|
      {
        time: hour[:time],
        temperature: hour[:temp_f],
        conditions: hour[:condition][:text],
        icon: hour[:condition][:icon]
      }
    end.flatten
  end
end