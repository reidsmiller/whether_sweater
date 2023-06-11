require 'rails_helper'

RSpec.describe 'Weather for city request' do
  describe 'can return forecast for a particular city' do
    it 'happy path', :vcr do
      get '/api/v0/forecast?location=denver,co', headers: { 'Content-Type' => 'application/json', 'Accept' => 'application/json' }

      expect(response).to be_successful
      expect(response.status).to eq(200)

      forecast = JSON.parse(response.body, symbolize_names: true)

      expect(forecast).to be_a(Hash)
      expect(forecast).to have_key(:data)
      expect(forecast[:data]).to be_a(Hash)

      expect(forecast[:data]).to have_key(:id)
      expect(forecast[:data][:id]).to eq(nil)

      expect(forecast[:data]).to have_key(:type)
      expect(forecast[:data][:type]).to eq('forecast')

      expect(forecast[:data]).to have_key(:attributes)
      expect(forecast[:data][:attributes]).to be_a(Hash)

      #Current Weather
      expect(forecast[:data][:attributes]).to have_key(:current_weather)
      expect(forecast[:data][:attributes][:current_weather]).to be_a(Hash)

      expect(forecast[:data][:attributes][:current_weather]).to have_key(:last_updated)
      expect(forecast[:data][:attributes][:current_weather][:last_updated]).to be_a(String)

      expect(forecast[:data][:attributes][:current_weather]).to have_key(:temperature)
      expect(forecast[:data][:attributes][:current_weather][:temperature]).to be_a(Float)

      expect(forecast[:data][:attributes][:current_weather]).to have_key(:feels_like)
      expect(forecast[:data][:attributes][:current_weather][:feels_like]).to be_a(Float)

      expect(forecast[:data][:attributes][:current_weather]).to have_key(:humidity)
      expect(forecast[:data][:attributes][:current_weather][:humidity]).to be_a(Integer)

      expect(forecast[:data][:attributes][:current_weather]).to have_key(:uvi)
      expect(forecast[:data][:attributes][:current_weather][:uvi]).to be_a(Float)

      expect(forecast[:data][:attributes][:current_weather]).to have_key(:visibility)
      expect(forecast[:data][:attributes][:current_weather][:visibility]).to be_a(Integer)

      expect(forecast[:data][:attributes][:current_weather]).to have_key(:conditions)
      expect(forecast[:data][:attributes][:current_weather][:conditions]).to be_a(String)

      expect(forecast[:data][:attributes][:current_weather]).to have_key(:icon)
      expect(forecast[:data][:attributes][:current_weather][:icon]).to be_a(String)

      expect(forecast[:data][:attributes]).to_not have_key(:time_epoch)
      expect(forecast[:data][:attributes]).to_not have_key(:wind_degree)
      expect(forecast[:data][:attributes]).to_not have_key(:wind_dir)
      expect(forecast[:data][:attributes]).to_not have_key(:pressure_mb)
      expect(forecast[:data][:attributes]).to_not have_key(:pressure_in)
      expect(forecast[:data][:attributes]).to_not have_key(:precip_mm)
      expect(forecast[:data][:attributes]).to_not have_key(:precip_in)
      expect(forecast[:data][:attributes]).to_not have_key(:feelslike_c)
      expect(forecast[:data][:attributes]).to_not have_key(:feelslike_f)
      expect(forecast[:data][:attributes]).to_not have_key(:vis_km)
      expect(forecast[:data][:attributes]).to_not have_key(:gust_mph)
      expect(forecast[:data][:attributes]).to_not have_key(:gust_kph)

      #Daily Weather
      expect(forecast[:data][:attributes]).to have_key(:daily_weather)
      expect(forecast[:data][:attributes][:daily_weather]).to be_a(Array)
      expect(forecast[:data][:attributes][:daily_weather].count).to eq(5)

      expect(forecast[:data][:attributes][:daily_weather][0]).to have_key(:date)
      expect(forecast[:data][:attributes][:daily_weather][0][:date]).to be_a(String)

      expect(forecast[:data][:attributes][:daily_weather][0]).to have_key(:sunrise)
      expect(forecast[:data][:attributes][:daily_weather][0][:sunrise]).to be_a(String)

      expect(forecast[:data][:attributes][:daily_weather][0]).to have_key(:sunset)
      expect(forecast[:data][:attributes][:daily_weather][0][:sunset]).to be_a(String)

      expect(forecast[:data][:attributes][:daily_weather][0]).to have_key(:max_temp)
      expect(forecast[:data][:attributes][:daily_weather][0][:max_temp]).to be_a(Float)

      expect(forecast[:data][:attributes][:daily_weather][0]).to have_key(:min_temp)
      expect(forecast[:data][:attributes][:daily_weather][0][:min_temp]).to be_a(Float)

      expect(forecast[:data][:attributes][:daily_weather][0]).to have_key(:conditions)
      expect(forecast[:data][:attributes][:daily_weather][0][:conditions]).to be_a(String)

      expect(forecast[:data][:attributes][:daily_weather][0]).to have_key(:icon)
      expect(forecast[:data][:attributes][:daily_weather][0][:icon]).to be_a(String)

      expect(forecast[:data][:attributes][:daily_weather][0]).to_not have_key(:maxtemp_f)
      expect(forecast[:data][:attributes][:daily_weather][0]).to_not have_key(:maxtemp_c)
      expect(forecast[:data][:attributes][:daily_weather][0]).to_not have_key(:mintemp_f)
      expect(forecast[:data][:attributes][:daily_weather][0]).to_not have_key(:mintemp_c)
      expect(forecast[:data][:attributes][:daily_weather][0]).to_not have_key(:avgtemp_f)
      expect(forecast[:data][:attributes][:daily_weather][0]).to_not have_key(:avgtemp_c)
      expect(forecast[:data][:attributes][:daily_weather][0]).to_not have_key(:maxwind_mph)
      expect(forecast[:data][:attributes][:daily_weather][0]).to_not have_key(:maxwind_kph)
      expect(forecast[:data][:attributes][:daily_weather][0]).to_not have_key(:totalprecip_mm)
      expect(forecast[:data][:attributes][:daily_weather][0]).to_not have_key(:totalprecip_in)
      expect(forecast[:data][:attributes][:daily_weather][0]).to_not have_key(:avgvis_km)
      expect(forecast[:data][:attributes][:daily_weather][0]).to_not have_key(:avgvis_miles)
      expect(forecast[:data][:attributes][:daily_weather][0]).to_not have_key(:avghumidity)
      expect(forecast[:data][:attributes][:daily_weather][0]).to_not have_key(:daily_will_it_rain)
      expect(forecast[:data][:attributes][:daily_weather][0]).to_not have_key(:daily_chance_of_rain)
      expect(forecast[:data][:attributes][:daily_weather][0]).to_not have_key(:daily_will_it_snow)
      expect(forecast[:data][:attributes][:daily_weather][0]).to_not have_key(:daily_chance_of_snow)

      #Hourly Weather
      expect(forecast[:data][:attributes]).to have_key(:hourly_weather)
      expect(forecast[:data][:attributes][:hourly_weather]).to be_a(Array)
      expect(forecast[:data][:attributes][:hourly_weather].count).to eq(24)

      expect(forecast[:data][:attributes][:hourly_weather][0]).to have_key(:time)
      expect(forecast[:data][:attributes][:hourly_weather][0][:time]).to be_a(String)

      expect(forecast[:data][:attributes][:hourly_weather][0]).to have_key(:temperature)
      expect(forecast[:data][:attributes][:hourly_weather][0][:temperature]).to be_a(Float)

      expect(forecast[:data][:attributes][:hourly_weather][0]).to have_key(:conditions)
      expect(forecast[:data][:attributes][:hourly_weather][0][:conditions]).to be_a(String)

      expect(forecast[:data][:attributes][:hourly_weather][0]).to have_key(:icon)
      expect(forecast[:data][:attributes][:hourly_weather][0][:icon]).to be_a(String)

      expect(forecast[:data][:attributes][:hourly_weather][0]).to_not have_key(:temp_f)
      expect(forecast[:data][:attributes][:hourly_weather][0]).to_not have_key(:temp_c)
      expect(forecast[:data][:attributes][:hourly_weather][0]).to_not have_key(:wind_mph)
      expect(forecast[:data][:attributes][:hourly_weather][0]).to_not have_key(:wind_kph)
      expect(forecast[:data][:attributes][:hourly_weather][0]).to_not have_key(:wind_degree)
      expect(forecast[:data][:attributes][:hourly_weather][0]).to_not have_key(:wind_dir)
      expect(forecast[:data][:attributes][:hourly_weather][0]).to_not have_key(:pressure_mb)
      expect(forecast[:data][:attributes][:hourly_weather][0]).to_not have_key(:pressure_in)
      expect(forecast[:data][:attributes][:hourly_weather][0]).to_not have_key(:precip_mm)
      expect(forecast[:data][:attributes][:hourly_weather][0]).to_not have_key(:precip_in)
      expect(forecast[:data][:attributes][:hourly_weather][0]).to_not have_key(:humidity)
      expect(forecast[:data][:attributes][:hourly_weather][0]).to_not have_key(:cloud)
      expect(forecast[:data][:attributes][:hourly_weather][0]).to_not have_key(:feelslike_f)
      expect(forecast[:data][:attributes][:hourly_weather][0]).to_not have_key(:feelslike_c)
      expect(forecast[:data][:attributes][:hourly_weather][0]).to_not have_key(:windchill_f)
      expect(forecast[:data][:attributes][:hourly_weather][0]).to_not have_key(:windchill_c)
      expect(forecast[:data][:attributes][:hourly_weather][0]).to_not have_key(:heatindex_f)
      expect(forecast[:data][:attributes][:hourly_weather][0]).to_not have_key(:heatindex_c)
      expect(forecast[:data][:attributes][:hourly_weather][0]).to_not have_key(:dewpoint_f)
      expect(forecast[:data][:attributes][:hourly_weather][0]).to_not have_key(:dewpoint_c)
      expect(forecast[:data][:attributes][:hourly_weather][0]).to_not have_key(:will_it_rain)
      expect(forecast[:data][:attributes][:hourly_weather][0]).to_not have_key(:chance_of_rain)
      expect(forecast[:data][:attributes][:hourly_weather][0]).to_not have_key(:will_it_snow)
      expect(forecast[:data][:attributes][:hourly_weather][0]).to_not have_key(:chance_of_snow)
      expect(forecast[:data][:attributes][:hourly_weather][0]).to_not have_key(:vis_km)
      expect(forecast[:data][:attributes][:hourly_weather][0]).to_not have_key(:vis_miles)
      expect(forecast[:data][:attributes][:hourly_weather][0]).to_not have_key(:gust_mph)
      expect(forecast[:data][:attributes][:hourly_weather][0]).to_not have_key(:gust_kph)
      expect(forecast[:data][:attributes][:hourly_weather][0]).to_not have_key(:uv)
    end

    it 'sad path, returns error if location is not found', :vcr do
      get '/api/v0/forecast?forecast?location=blargland,blork'

      expect(response).to_not be_successful
      expect(response.status).to eq(400)

      error = JSON.parse(response.body, symbolize_names: true)

      expect(error).to be_a(Hash)
      expect(error[:errors][:detail]).to eq('Illegal argument from request: Insufficient info for location')
    end
  end
end