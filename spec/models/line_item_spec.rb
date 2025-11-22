require 'rails_helper'

describe LineItem, type: :model do
  let(:user) { User.create(email: 'test@example.com', password: 'password123') }
  let(:timesheet) { user.time_sheets.create(description: 'Week 1', rate: 50) }

  describe 'associations' do
    it { is_expected.to belong_to(:time_sheet) }
  end

  describe 'callbacks' do
    it 'updates timesheet total_time when created' do
      lineitem = timesheet.line_items.create(date: '2024-01-15', minutes: 120)

      expect(timesheet.reload.total_time).to eq(120)
    end

    it 'updates timesheet total_cost when created' do
      lineitem = timesheet.line_items.create(date: '2024-01-15', minutes: 120)

      expect(timesheet.reload.total_cost).to eq(6000) # 120 * 50
    end
  end
end
