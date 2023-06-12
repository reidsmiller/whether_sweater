require 'rails_helper'

RSpec.describe BookService do
  context 'instance methods' do
    context '#books' do
      it 'returns book data', :vcr do
        search = BookService.new.books('denver,co', 5)

        expect(search).to be_a(Hash)

        expect(search).to have_key(:numFound)
        expect(search[:numFound]).to be_a(Integer)

        expect(search).to have_key(:docs)
        expect(search[:docs]).to be_a(Array)
        expect(search[:docs].count).to eq(5)

        expect(search[:docs].first).to have_key(:title)
        expect(search[:docs].first[:title]).to be_a(String)

        expect(search[:docs].first).to have_key(:isbn)
        expect(search[:docs].first[:isbn]).to be_a(Array)
        expect(search[:docs].first[:isbn].first).to be_a(String)

        expect(search[:docs].first).to have_key(:publisher)
        expect(search[:docs].first[:publisher]).to be_a(Array)
        expect(search[:docs].first[:publisher].first).to be_a(String)
      end
    end
  end
end