require 'rails_helper'

RSpec.describe ForecastFacade do
  describe 'instance methods' do
    before(:each) do
      @facade = ForecastFacade.new('denver,co')
    end

    it 'returns a geolocation object', :vcr do
      expect(@facade.geolocation).to be_a(Geolocation)
    end

    it 'returns a forecast object', :vcr do
      expect(@facade.forecast).to be_a(Forecast)
    end
  end
end