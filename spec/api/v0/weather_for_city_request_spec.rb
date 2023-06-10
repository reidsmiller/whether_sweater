require 'rails_helper'

RSpec.describe 'Weather for city request' do
  describe 'can return forecast for a particular city' do
    it 'happy path' do
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

      expect(forecast[:data][:attributes][:daily_weather][0]).to have_key(:condition)
      expect(forecast[:data][:attributes][:daily_weather][0][:conditions]).to be_a(String)

      expect(forecast[:data][:attributes][:daily_weather][0]).to have_key(:icon)
      expect(forecast[:data][:attributes][:daily_weather][0][:icon]).to be_a(String)

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
    end
  end
end