class User < ApplicationRecord
  include Hashidable
  has_secure_password
  has_many :time_sheets, dependent: :destroy

  validates :email, presence: true, uniqueness: true
end
