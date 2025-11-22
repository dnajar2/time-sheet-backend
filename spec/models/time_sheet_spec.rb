require 'rails_helper'

describe TimeSheet, type: :model do
  let(:user) { User.create(email: 'test@example.com', password: 'password123') }

  describe 'validations' do
    it { is_expected.to validate_presence_of(:description) }
    it { is_expected.to validate_presence_of(:rate) }
    it { is_expected.to validate_numericality_of(:rate).is_greater_than(0) }
  end

  describe 'associations' do
    it { is_expected.to belong_to(:user) }
    it { is_expected.to have_many(:line_items) }
  end

  describe '#total_time' do
    let(:timesheet) { user.time_sheets.create(description: 'Week 1', rate: 50) }

    it 'sums all line item minutes' do
      timesheet.line_items.create(date: '2024-01-15', minutes: 120)
      timesheet.line_items.create(date: '2024-01-16', minutes: 60)

      expect(timesheet.total_time).to eq(180)
    end
  end

  describe '#total_cost' do
    let(:timesheet) { user.time_sheets.create(description: 'Week 1', rate: 50) }

    it 'calculates total_time * rate' do
      timesheet.line_items.create(date: '2024-01-15', minutes: 120)
      timesheet.line_items.create(date: '2024-01-16', minutes: 60)

      expect(timesheet.total_cost).to eq(9000) # 180 minutes * 50 rate
    end
  end
end