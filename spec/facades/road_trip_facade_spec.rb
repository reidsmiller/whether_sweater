require 'rails_helper'

RSpec.describe RoadTripFacade do
  describe 'instance methods' do
    before(:each) do
      @facade = RoadTripFacade.new({
        origin: 'denver,co',
        destination: 'pueblo,co'
      }, ForecastFacade.new('pueblo,co').weather_data)
    end

    it 'returns a road trip object', :vcr do
      expect(@facade.road_trip).to be_a(RoadTrip)
    end
  end
end