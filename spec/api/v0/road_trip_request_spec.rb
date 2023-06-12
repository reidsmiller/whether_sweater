require 'rails_helper'

RSpec.describe 'Road Trip Request' do
  before(:each) do
    @user = User.create!(email: 'whatever@example.com', password: 'password123', password_confirmation: 'password123')
  end

  describe 'it can return road trip data' do
    it 'happy path', :vcr do
      get '/api/v0/road_trip', headers: { 'Content-Type' => 'application/json', 'Accept' => 'application/json' },
                               params: JSON.generate({
                                                       "origin:": 'Denver,CO',
                                                       "destination": 'Boston,MA',
                                                       "api_key": @user.api_key
                                                     })

      expect(response).to be_successful
      expect(response.status).to eq(200)

      road_trip = JSON.parse(response.body, symbolize_names: true)

      expect(road_trip).to be_a(Hash)
      expect(road_trip).to have_key(:data)
      expect(road_trip[:data]).to be_a(Hash)

      expect(road_trip[:data]).to have_key(:id)
      expect(road_trip[:data][:id]).to be_a(String)

      expect(road_trip[:data]).to have_key(:type)
      expect(road_trip[:data][:type]).to be_a(String)

      expect(road_trip[:data]).to have_key(:attributes)
      expect(road_trip[:data][:attributes]).to be_a(Hash)

      expect(road_trip[:data][:attributes]).to have_key(:start_city)
      expect(road_trip[:data][:attributes][:start_city]).to be_a(String)

      expect(road_trip[:data][:attributes]).to have_key(:end_city)
      expect(road_trip[:data][:attributes][:end_city]).to be_a(String)

      expect(road_trip[:data][:attributes]).to have_key(:travel_time)
      expect(road_trip[:data][:attributes][:travel_time]).to be_a(String)

      expect(road_trip[:data][:attributes]).to have_key(:weather_at_eta)
      expect(road_trip[:data][:attributes][:weather_at_eta]).to be_a(Hash)

      expect(road_trip[:data][:attributes][:weather_at_eta]).to have_key(:datetime)
      expect(road_trip[:data][:attributes][:weather_at_eta][:datetime]).to be_a(String)

      expect(road_trip[:data][:attributes][:weather_at_eta]).to have_key(:temperature)
      expect(road_trip[:data][:attributes][:weather_at_eta][:temperature]).to be_a(Float)

      expect(road_trip[:data][:attributes][:weather_at_eta]).to have_key(:condition)
      expect(road_trip[:data][:attributes][:weather_at_eta][:condition]).to be_a(String)
    end

    it 'impossible route', :vcr do
      get '/api/v0/road_trip', headers: { 'Content-Type' => 'application/json', 'Accept' => 'application/json' },
                               params: JSON.generate({
                                                       "origin:": 'Denver,CO',
                                                       "destination": 'Lunar Base Alpha, The Moon',
                                                       "api_key": @user.api_key
                                                     })

      expect(response).to be_successful
      expect(response.status).to eq(200)

      road_trip = JSON.parse(response.body, symbolize_names: true)

      expect(road_trip).to be_a(Hash)
      expect(road_trip).to have_key(:data)
      expect(road_trip[:data]).to be_a(Hash)

      expect(road_trip[:data]).to have_key(:id)
      expect(road_trip[:data][:id]).to be_a(String)

      expect(road_trip[:data]).to have_key(:type)
      expect(road_trip[:data][:type]).to be_a(String)

      expect(road_trip[:data]).to have_key(:attributes)
      expect(road_trip[:data][:attributes]).to be_a(Hash)

      expect(road_trip[:data][:attributes]).to have_key(:start_city)
      expect(road_trip[:data][:attributes][:start_city]).to be_a(String)

      expect(road_trip[:data][:attributes]).to have_key(:end_city)
      expect(road_trip[:data][:attributes][:end_city]).to be_a(String)

      expect(road_trip[:data][:attributes]).to have_key(:travel_time)
      expect(road_trip[:data][:attributes][:travel_time]).to eq('impossible route')

      expect(road_trip[:data][:attributes]).to have_key(:weather_at_eta)
      expect(road_trip[:data][:attributes][:weather_at_eta]).to eq({})
    end

    describe 'sad path' do
      it 'invalid api key', :vcr do
        get '/api/v0/road_trip', headers: { 'Content-Type' => 'application/json', 'Accept' => 'application/json' },
                                 params: JSON.generate({
                                                         "origin:": 'Denver,CO',
                                                         "destination": 'Boston,MA',
                                                         "api_key": '1234566sdksjd;tlksaasdf'
                                                       })

        expect(response).to_not be_successful
        expect(response.status).to eq(401)

        error = JSON.parse(response.body, symbolize_names: true)

        expect(error[:errors][:detail]).to eq('Validation Error: Invalid API key')
      end

      it 'missing api key', :vcr do
        get '/api/v0/road_trip', headers: { 'Content-Type' => 'application/json', 'Accept' => 'application/json' },
                                 params: JSON.generate({
                                                         "origin:": 'Denver,CO',
                                                         "destination": 'Boston,MA'
                                                       })

        expect(response).to_not be_successful
        expect(response.status).to eq(401)

        error = JSON.parse(response.body, symbolize_names: true)

        expect(error[:errors][:detail]).to eq('Validation Error: Invalid API key')
      end

      it 'invalid origin', :vcr do
        get '/api/v0/road_trip', headers: { 'Content-Type' => 'application/json', 'Accept' => 'application/json' },
                                 params: JSON.generate({
                                                         "origin:": 'blargland,blork',
                                                         "destination": 'Boston,MA',
                                                         "api_key": @user.api_key
                                                       })

        expect(response).to_not be_successful
        expect(response.status).to eq(401)

        error = JSON.parse(response.body, symbolize_names: true)

        expect(error[:errors][:detail]).to eq('Invalid location')
      end

      it 'invalid destination', :vcr do
        get '/api/v0/road_trip', headers: { 'Content-Type' => 'application/json', 'Accept' => 'application/json' },
                                 params: JSON.generate({
                                                         "origin:": 'Denver,CO',
                                                         "destination": 'Lunar Base Alpha, The Moon',
                                                         "api_key": @user.api_key
                                                       })

        expect(response).to_not be_successful
        expect(response.status).to eq(401)

        error = JSON.parse(response.body, symbolize_names: true)

        expect(error[:errors][:detail]).to eq('Invalid location')
      end

    end
  end
end