require 'rails_helper'

RSpec.describe RoadTrip do
  before(:each) do
    @data = {
      route: {
        distance: 1973.9447,
        time: 99_012,
        formattedTime: '27:30:12'
      },
      info: {
        statuscode: 0
      }
    }
    @forecast1 = {
      location: {
        localtime: '2023-06-14 20:00',
      },
      forecast:{
        forecastday: [{
          date: '2023-06-15',
          hour: [{
            time: '2023-06-15 00:00',
            temp_f: 'bad temp',
            condition: {
              text: 'bad condition'
            }
          }]
        }, {
          date: '2023-06-16',
          hour: [{
            time: '2023-06-16 00:00',
            temp_f: 67.3,
            condition: {
              text: 'sunshiney happy day'
            }
          }, {
            time: '2023-06-16 01:00',
            temp_f: 67.3,
            condition: {
              text: 'sunshiney happy day'
            }
          }]
        }]
      }
    }
    @forecast2 = {
      location: {
        localtime: '2023-06-14 19:50',
      },
      forecast:{
        forecastday: [{
          date: '2023-06-15',
          hour: [{
            time: '2023-06-15 23:00',
            temp_f: 'bad temp',
            condition: {
              text: 'bad condition'
            }
          }]
        }, {
          date: '2023-06-16',
          hour: [{
            time: '2023-06-16 00:00',
            temp_f: 67.3,
            condition: {
              text: 'sunshiney happy day'
            }
          }, {
            time: '2023-06-16 01:00',
            temp_f: 67.3,
            condition: {
              text: 'sunshiney happy day'
            }
          }]
        }]
      }
    }
    @origin = 'denver,co'
    @destination = 'boston,ma'
  end

  it 'exists and has attributes' do
    road_trip = RoadTrip.new(@data, @forecast1, @origin, @destination)

    expect(road_trip).to be_a(RoadTrip)
    expect(road_trip.id).to eq('null')
    expect(road_trip.type).to eq('road_trip')
    expect(road_trip.start_city).to eq(@origin)
    expect(road_trip.end_city).to eq(@destination)
    expect(road_trip.travel_time).to eq(@data[:route][:formattedTime])
    expect(road_trip.weather_at_eta).to be_a(Hash)
    expect(road_trip.weather_at_eta[:datetime]).to eq('2023-06-16 00:00')
    expect(road_trip.weather_at_eta[:temperature]).to eq(67.3)
    expect(road_trip.weather_at_eta[:condition]).to eq('sunshiney happy day')
  end

  it 'can format travel time' do
    road_trip = RoadTrip.new(@data, @forecast1, @origin, @destination)

    expect(road_trip.format_travel_time(@data)).to eq('27:30:12')
  end

  it 'can format weather at eta' do
    road_trip = RoadTrip.new(@data, @forecast1, @origin, @destination)
    time = @data[:route][:time]

    expect(road_trip.format_weather_at_eta(time, @forecast1)).to be_a(Hash)
    expect(road_trip.format_weather_at_eta(time, @forecast1)[:datetime]).to eq('2023-06-16 00:00')
    expect(road_trip.format_weather_at_eta(time, @forecast1)[:temperature]).to eq(67.3)
    expect(road_trip.format_weather_at_eta(time, @forecast1)[:condition]).to eq('sunshiney happy day')
  end

  it 'can caculate arrival time' do
    road_trip = RoadTrip.new(@data, @forecast2, @origin, @destination)

    expect(road_trip.calculate_datetime(@data[:route][:time], @forecast1)).to eq('2023-06-16 00:00')
    expect(road_trip.calculate_datetime(@data[:route][:time], @forecast2)).to eq('2023-06-15 23:00')
  end
end