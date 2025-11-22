class TimeSheet < ApplicationRecord
  belongs_to :user
  has_many :line_items, dependent: :destroy
  accepts_nested_attributes_for :line_items, allow_destroy: true

  validates :description, presence: true
  validates :rate, presence: true, numericality: { greater_than: 0 }
  validates :user_id, presence: true

    def total_time
    line_items.sum(:minutes)
  end
  
  def total_cost
    total_time * rate
  end
end
