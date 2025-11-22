require 'rails_helper'

describe 'Api::V1::Timesheets', type: :request do
  let!(:user) { User.create(email: 'test@example.com', password: 'password123') }
  let(:token) { JWT.encode({ user_id: user.id, exp: 24.hours.from_now.to_i }, Rails.application.secret_key_base, 'HS256') }
  let(:headers) { { 'Authorization' => "Bearer #{token}" } }

  describe 'POST /api/v1/timesheets' do
    it 'creates a timesheet for authenticated user' do
      post '/api/v1/timesheets', params: {
        time_sheet: {
          description: 'Week 1',
          rate: 50
        }
      }, headers: headers

      expect(response).to have_http_status(:created)
      expect(user.time_sheets.count).to eq(1)
    end

    it 'returns 401 without token' do
      post '/api/v1/timesheets', params: {
        time_sheet: {
          description: 'Week 1',
          rate: 50
        }
      }

      expect(response).to have_http_status(:unauthorized)
    end
  end

  describe 'GET /api/v1/timesheets' do
    let!(:timesheet) { user.time_sheets.create(description: 'Week 1', rate: 50) }

    it 'returns timesheets for authenticated user' do
      get '/api/v1/timesheets', headers: headers

      expect(response).to have_http_status(:ok)
      expect(JSON.parse(response.body).length).to eq(1)
    end
  end
end
