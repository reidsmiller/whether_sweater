require 'rails_helper'

RSpec.describe 'Book Location Search Request' do
  describe 'it can search for a list of books about a specific location and return weather data' do
    it 'happy path', :vcr do
      get '/api/v0/book-search?location=denver,co&quantity=5', headers: { 'Content-Type' => 'application/json', 'Accept' => 'application/json' }

      expect(response).to be_successful
      expect(response.status).to eq(200)

      books = JSON.parse(response.body, symbolize_names: true)

      expect(books).to be_a(Hash)
      expect(books).to have_key(:data)
      expect(books[:data]).to be_a(Hash)

      expect(books[:data]).to have_key(:id)
      expect(books[:data][:id]).to eq(nil)

      expect(books[:data]).to have_key(:type)
      expect(books[:data][:type]).to eq('book')

      expect(books[:data]).to have_key(:attributes)
      expect(books[:data][:attributes]).to be_a(Hash)

      #forecast
      expect(books[:data][:attributes]).to have_key(:destination)
      expect(books[:data][:attributes][:destination]).to be_a(String)

      expect(books[:data][:attributes]).to have_key(:forecast)
      expect(books[:data][:attributes][:forecast]).to be_a(Hash)

      expect(books[:data][:attributes][:forecast]).to have_key(:summary)
      expect(books[:data][:attributes][:forecast][:summary]).to be_a(String)

      expect(books[:data][:attributes][:forecast]).to have_key(:temperature)
      expect(books[:data][:attributes][:forecast][:temperature]).to be_a(String)

      #books
      expect(books[:data][:attributes]).to have_key(:total_books_found)
      expect(books[:data][:attributes][:total_books_found]).to be_a(Integer)

      expect(books[:data][:attributes]).to have_key(:books)
      expect(books[:data][:attributes][:books]).to be_a(Array)
      expect(books[:data][:attributes][:books].count).to eq(5)

      expect(books[:data][:attributes][:books][0]).to have_key(:isbn)
      expect(books[:data][:attributes][:books][0][:isbn]).to be_an(Array)
      expect(books[:data][:attributes][:books][0][:isbn][0]).to be_a(String)

      expect(books[:data][:attributes][:books][0]).to have_key(:title)
      expect(books[:data][:attributes][:books][0][:title]).to be_a(String)

      expect(books[:data][:attributes][:books][0]).to have_key(:publisher)
      expect(books[:data][:attributes][:books][0][:publisher]).to be_a(Array)
      expect(books[:data][:attributes][:books][0][:publisher][0]).to be_a(String)
    end

    describe 'sad path' do
      it 'location is not valid', :vcr do
        get '/api/v0/book-search?location=blargland,blork&quantity=5', headers: { 'Content-Type' => 'application/json', 'Accept' => 'application/json' }

        expect(response).to_not be_successful
        expect(response.status).to eq(400)

        error = JSON.parse(response.body, symbolize_names: true)

        expect(error[:errors][:detail]).to eq('Invalid location')
      end
    end
  end
end