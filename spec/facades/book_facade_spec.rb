require 'rails_helper'

RSpec.describe BookFacade do
  describe 'instance methods' do
    before(:each) do
      @facade = BookFacade.new({
        location: 'denver,co',
        quantity: 5
      }, ForecastFacade.new('denver,co').forecast)
    end

    it 'returns a book object', :vcr do
      expect(@facade.books).to be_a(Book)
    end
  end
end