require 'rails_helper'

RSpec.describe WeatherApiService do
  context 'instance methods' do
    context '#weather' do
      it 'returns weather data', :vcr do
        search = WeatherApiService.new.weather(39.738453, -104.984853)

        expect(search).to be_a(Hash)
        expect(search).to have_key(:current)

        #current weather
        expect(search[:current]).to be_a(Hash)

        expect(search[:current]).to have_key(:last_updated)
        expect(search[:current][:last_updated]).to be_a(String)

        expect(search[:current]).to have_key(:temp_f)
        expect(search[:current][:temp_f]).to be_a(Float)

        expect(search[:current]).to have_key(:feelslike_f)
        expect(search[:current][:feelslike_f]).to be_a(Float)

        expect(search[:current]).to have_key(:humidity)
        expect(search[:current][:humidity]).to be_a(Integer)

        expect(search[:current]).to have_key(:uv)
        expect(search[:current][:uv]).to be_a(Float)

        expect(search[:current]).to have_key(:vis_miles)
        expect(search[:current][:vis_miles]).to be_a(Float)

        expect(search[:current]).to have_key(:condition)
        expect(search[:current][:condition]).to be_a(Hash)

        expect(search[:current][:condition]).to have_key(:text)
        expect(search[:current][:condition][:text]).to be_a(String)

        expect(search[:current][:condition]).to have_key(:icon)
        expect(search[:current][:condition][:icon]).to be_a(String)

        #daily weather
        expect(search).to have_key(:forecast)
        expect(search[:forecast]).to be_a(Hash)

        expect(search[:forecast]).to have_key(:forecastday)
        expect(search[:forecast][:forecastday]).to be_a(Array)

        expect(search[:forecast][:forecastday].first).to have_key(:date)
        expect(search[:forecast][:forecastday].first[:date]).to be_a(String)

        expect(search[:forecast][:forecastday].first).to have_key(:astro)
        expect(search[:forecast][:forecastday].first[:astro]).to be_a(Hash)

        expect(search[:forecast][:forecastday].first[:astro]).to have_key(:sunrise)
        expect(search[:forecast][:forecastday].first[:astro][:sunrise]).to be_a(String)

        expect(search[:forecast][:forecastday].first[:astro]).to have_key(:sunset)
        expect(search[:forecast][:forecastday].first[:astro][:sunset]).to be_a(String)

        expect(search[:forecast][:forecastday].first).to have_key(:day)
        expect(search[:forecast][:forecastday].first[:day]).to be_a(Hash)

        expect(search[:forecast][:forecastday].first[:day]).to have_key(:maxtemp_f)
        expect(search[:forecast][:forecastday].first[:day][:maxtemp_f]).to be_a(Float)

        expect(search[:forecast][:forecastday].first[:day]).to have_key(:mintemp_f)
        expect(search[:forecast][:forecastday].first[:day][:mintemp_f]).to be_a(Float)

        expect(search[:forecast][:forecastday].first[:day]).to have_key(:condition)
        expect(search[:forecast][:forecastday].first[:day][:condition]).to be_a(Hash)

        expect(search[:forecast][:forecastday].first[:day][:condition]).to have_key(:text)
        expect(search[:forecast][:forecastday].first[:day][:condition][:text]).to be_a(String)

        expect(search[:forecast][:forecastday].first[:day][:condition]).to have_key(:icon)
        expect(search[:forecast][:forecastday].first[:day][:condition][:icon]).to be_a(String)

        #hourly weather
        expect(search[:forecast][:forecastday].first).to have_key(:hour)
        expect(search[:forecast][:forecastday].first[:hour]).to be_a(Array)

        expect(search[:forecast][:forecastday].first[:hour].first).to have_key(:time)
        expect(search[:forecast][:forecastday].first[:hour].first[:time]).to be_a(String)

        expect(search[:forecast][:forecastday].first[:hour].first).to have_key(:temp_f)
        expect(search[:forecast][:forecastday].first[:hour].first[:temp_f]).to be_a(Float)

        expect(search[:forecast][:forecastday].first[:hour].first).to have_key(:condition)
        expect(search[:forecast][:forecastday].first[:hour].first[:condition]).to be_a(Hash)

        expect(search[:forecast][:forecastday].first[:hour].first[:condition]).to have_key(:text)
        expect(search[:forecast][:forecastday].first[:hour].first[:condition][:text]).to be_a(String)

        expect(search[:forecast][:forecastday].first[:hour].first[:condition]).to have_key(:icon)
        expect(search[:forecast][:forecastday].first[:hour].first[:condition][:icon]).to be_a(String)
      end
    end
  end
end