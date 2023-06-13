class RoadTrip
  attr_reader :id, :type, :start_city, :end_city, :travel_time, :weather_at_eta

  def initialize(data, forecast, origin, destination)
    @id = 'null'
    @type = 'road_trip'
    @start_city = origin
    @end_city = destination
    @travel_time = format_travel_time(data)
    @weather_at_eta = format_weather_at_eta(data[:route][:time], forecast)
  end

  def format_travel_time(data)
    if data[:info][:statuscode] != 0
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
    rounded_time = if arrival_time.min >= 30
                     arrival_time.change(min: 0, hour: arrival_time.hour + 1)
                   else
                     arrival_time.change(min: 0)
                   end
    rounded_time.strftime('%Y-%m-%d %H:%M')
  end
end