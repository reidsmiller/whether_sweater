require 'rails_helper'

RSpec.describe 'User Login Request' do
  describe 'it logs in a user and returns an api key' do
    it 'happy path', :vcr do
      User.create!(email: 'whatever@example.com', password: 'password123', password_confirmation: 'password123')
      post '/api/v0/sessions', headers: { 'CONTENT_TYPE' => 'application/json', 'ACCEPT' => 'application/json' },
                               params: JSON.generate({
                                                       "email": 'whatever@example.com',
                                                       "password": 'password123'
                                                     })

      expect(response).to be_successful
      expect(response.status).to eq(200)

      user = JSON.parse(response.body, symbolize_names: true)

      expect(user).to be_a(Hash)
      expect(user).to have_key(:data)
      expect(user[:data]).to be_a(Hash)

      expect(user[:data]).to have_key(:id)
      expect(user[:data][:id]).to be_a(String)

      expect(user[:data]).to have_key(:type)
      expect(user[:data][:type]).to be_a(String)

      expect(user[:data]).to have_key(:attributes)
      expect(user[:data][:attributes]).to be_a(Hash)

      expect(user[:data][:attributes]).to have_key(:email)
      expect(user[:data][:attributes][:email]).to be_a(String)

      expect(user[:data][:attributes]).to have_key(:api_key)
      expect(user[:data][:attributes][:api_key]).to be_a(String)
    end

    describe 'sad path' do
      it 'email does not exist', :vcr do
        User.create!(email: 'whatever@example.com', password: 'password123', password_confirmation: 'password123')
        post '/api/v0/sessions', headers: { 'CONTENT_TYPE' => 'application/json', 'ACCEPT' => 'application/json' },
                                 params: JSON.generate({
                                                         "email:": 'however@example.com',
                                                         "password": 'password123'
                                                       })
        expect(response).to_not be_successful
        expect(response.status).to eq(401)

        error = JSON.parse(response.body, symbolize_names: true)

        expect(error[:errors][:detail]).to eq('Invalid credentials')
      end

      it 'password does not match', :vcr do
        User.create!(email: 'whatever@example.com', password: 'password123', password_confirmation: 'password123')
        post '/api/v0/sessions', headers: { 'CONTENT_TYPE' => 'application/json', 'ACCEPT' => 'application/json' },
                                 params: JSON.generate({
                                                         "email:": 'whatever@example.com',
                                                         "password": 'password987'
                                                       })
        expect(response).to_not be_successful
        expect(response.status).to eq(401)

        error = JSON.parse(response.body, symbolize_names: true)

        expect(error[:errors][:detail]).to eq('Invalid credentials')
      end
    end
  end
end