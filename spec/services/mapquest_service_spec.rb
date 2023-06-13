require 'rails_helper'

RSpec.describe MapquestService do
  context 'instance methods' do
    context '#geocode' do
      it 'returns geolocation data', :vcr do
        search = MapquestService.new.geocode('denver,co')

        expect(search).to be_a(Hash)
        expect(search).to have_key(:results)
        expect(search[:results]).to be_a(Array)

        expect(search[:results].first).to have_key(:locations)
        expect(search[:results].first[:locations]).to be_a(Array)

        expect(search[:results].first[:locations].first).to have_key(:latLng)
        expect(search[:results].first[:locations].first[:latLng]).to be_a(Hash)

        expect(search[:results].first[:locations].first[:latLng]).to have_key(:lat)
        expect(search[:results].first[:locations].first[:latLng][:lat]).to be_a(Float)

        expect(search[:results].first[:locations].first[:latLng]).to have_key(:lng)
        expect(search[:results].first[:locations].first[:latLng][:lng]).to be_a(Float)
      end

      it 'returns direction data', :vcr do
        search = MapquestService.new.road_trip('denver,co', 'pueblo,co')

        expect(search).to be_a(Hash)
        expect(search).to have_key(:route)
        expect(search[:route]).to be_a(Hash)

        expect(search[:route]).to have_key(:formattedTime)
        expect(search[:route][:formattedTime]).to be_a(String)
      end
    end
  end
end