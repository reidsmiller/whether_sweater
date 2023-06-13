class RoadTrip
  attr_reader :id, :type, :start_city, :end_city, :travel_time, :weather_at_eta

  def initialize(data, forecast, origin, destination)
    @id = nil
    @type = 'roadtrip'
    @start_city = origin
    @end_city = destination
    @travel_time = format_travel_time(data)
    @weather_at_eta = format_weather_at_eta(data[:route][:time], forecast)
  end

  def format_travel_time(data)
    if data[:info][:messages].include?('We are unable to route with the given locations.')
      'impossible route'
    else
      data[:route][:formattedTime]
    end
  end

  def format_weather_at_eta(time, forecast)
    if @travel_time == 'impossible route'
      {}
    else
      arrival_forecast = find_arrival_forecast(time, forecast)
      {
        datetime: arrival_forecast[:time],
        temperature: arrival_forecast[:temp_f],
        condition: arrival_forecast[:condition][:text]
      }
    end
  end

  def find_arrival_forecast(time, forecast)
    arrival_time = calculate_datetime(time, forecast)
    arrival_date = arrival_time.split(' ')[0]
    forecast_day = forecast[:forecast][:forecastday].find { |day| day[:date] == arrival_date }
    forecast_day[:hour].find { |hour| hour[:time] == arrival_time }
  end

  def calculate_datetime(time, forecast)
    arrival_time = DateTime.parse(forecast[:location][:localtime]) + time.seconds
    rounded_time = arrival_time.change(min: arrival_time.min >= 30 ? 60 : 0)
    rounded_time = rounded_time.change(hour: rounded_time.hour + 1) if rounded_time.min == 60
    rounded_time.strftime('%Y-%m-%d %H:%M')
  end
end