require 'rails_helper'

RSpec.describe 'User Registration Request' do
  describe 'it creates a user and returns an api key' do
    it 'happy path', :vcr do
      post '/api/v0/users', headers: { 'CONTENT_TYPE' => 'application/json', 'ACCEPT' => 'application/json' },
                            params: JSON.generate({
                                                    "email": 'whatever@example.com',
                                                    "password": 'password123',
                                                    "password_confirmation": 'password123'
                                                  })

      expect(response).to be_successful
      expect(response.status).to eq(201)

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

    it 'sad_path: passwords do not match', :vcr do
      post '/api/v0/users', headers: { 'CONTENT_TYPE' => 'application/json', 'ACCEPT' => 'application/json' },
                            params: JSON.generate({
                                                    "email": 'whatever@example.com',
                                                    "password": 'password123',
                                                    "password_confirmation": 'passwordaaaaaaaaargh'
                                                  })

      expect(response).to_not be_successful
      expect(response.status).to eq(422)

      error = JSON.parse(response.body, symbolize_names: true)

      expect(error[:errors][:detail]).to eq("Validation failed: Password confirmation doesn't match Password")
    end

    it 'sad_path: email already exists', :vcr do
      User.create!(email: 'whatever@example.com', password: 'password123', password_confirmation: 'password123')
      post '/api/v0/users', headers: { 'CONTENT_TYPE' => 'application/json', 'ACCEPT' => 'application/json' },
                            params: JSON.generate({
                                                    "email": 'whatever@example.com',
                                                    "password": 'password123',
                                                    "password_confirmation": 'password123'
                                                  })

      expect(response).to_not be_successful
      expect(response.status).to eq(422)

      error = JSON.parse(response.body, symbolize_names: true)

      expect(error[:errors][:detail]).to eq('Validation failed: Email has already been taken')
    end

    it 'sad_path: missing email', :vcr do
      post '/api/v0/users', headers: { 'CONTENT_TYPE' => 'application/json', 'ACCEPT' => 'application/json' },
                            params: JSON.generate({
                                                    "password": 'password123',
                                                    "password_confirmation": 'password123'
                                                  })

      expect(response).to_not be_successful
      expect(response.status).to eq(422)

      error = JSON.parse(response.body, symbolize_names: true)

      expect(error[:errors][:detail]).to eq("Validation failed: Email can't be blank")
    end

    it 'sad_path: missing password', :vcr do
      post '/api/v0/users', headers: { 'CONTENT_TYPE' => 'application/json', 'ACCEPT' => 'application/json' },
                            params: JSON.generate({
                                                    "email": 'whatever@example.com',
                                                    "password": '',
                                                    "password_confirmation": ''
                                                  })

      expect(response).to_not be_successful
      expect(response.status).to eq(422)

      error = JSON.parse(response.body, symbolize_names: true)

      expect(error[:errors][:detail]).to eq("Validation failed: Password can't be blank, Password can't be blank")
    end
  end
end