require 'rails_helper'

RSpec.describe Book do
  before(:each) do
    @data = {
      docs: [
        {
          isbn: [
            '9781338030002',
            '1338030003'
          ],
          title: 'Fantastic Beasts and Where to Find Them: The Original Screenplay',
          publisher: [
            'Arthur A. Levine Books'
          ]
        }
      ]
    }
    @location = 'denver,co'
    @forecast = ForecastFacade.new(@location).forecast
  end

  it 'exists', :vcr do
    book = Book.new(@data, @location, @forecast)

    expect(book).to be_a(Book)
    expect(book.destination).to eq(@location)
    expect(book.books).to be_a(Array)
    expect(book.books[0][:isbn][0]).to eq(@data[:docs][0][:isbn][0])
    expect(book.books[0][:title]).to eq(@data[:docs][0][:title])
    expect(book.books[0][:publisher][0]).to eq(@data[:docs][0][:publisher][0])
  end
end