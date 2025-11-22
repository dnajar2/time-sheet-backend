require 'rails_helper'

describe User, type: :model do
  describe 'validations' do
    it { is_expected.to validate_presence_of(:email) }
    it { is_expected.to validate_uniqueness_of(:email) }
  end

  describe 'associations' do
    it { is_expected.to have_many(:time_sheets) }
  end

  describe '#authenticate' do
    let(:user) { User.create(email: 'test@example.com', password: 'password123') }

    it 'authenticates with correct password' do
      expect(user.authenticate('password123')).to be_truthy
    end

    it 'fails with wrong password' do
      expect(user.authenticate('wrong')).to be_falsy
    end
  end
end