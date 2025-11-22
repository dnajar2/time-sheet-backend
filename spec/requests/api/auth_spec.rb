require 'rails_helper'

describe 'Api::V1::Auth', type: :request do
  describe 'POST /api/v1/auth/sign_up' do
    it 'creates a new user and returns a token' do
      post '/api/v1/auth/sign_up', params: {
        user: {
          email: 'test@example.com',
          password: 'password123',
          password_confirmation: 'password123'
        }
      }

      expect(response).to have_http_status(:created)
      expect(JSON.parse(response.body)).to have_key('token')
      expect(User.count).to eq(1)
    end
  end

  describe 'POST /api/v1/auth/login' do
    let!(:user) { User.create(email: 'test@example.com', password: 'password123') }

    it 'returns a token for valid credentials' do
      post '/api/v1/auth/login', params: {
        email: 'test@example.com',
        password: 'password123'
      }

      expect(response).to have_http_status(:ok)
      expect(JSON.parse(response.body)).to have_key('token')
    end

    it 'returns error for invalid credentials' do
      post '/api/v1/auth/login', params: {
        email: 'test@example.com',
        password: 'wrong'
      }

      expect(response).to have_http_status(:unauthorized)
    end
  end
end
