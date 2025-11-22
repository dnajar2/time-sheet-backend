class LineItem < ApplicationRecord
  belongs_to :time_sheet

  after_create :update_time_sheet
  after_update :update_time_sheet
  after_destroy :update_time_sheet

  def update_time_sheet
    time_sheet.update(
      total_time: time_sheet.line_items.sum(:minutes),
      total_cost: time_sheet.line_items.sum(:minutes) * time_sheet.rate
    )
  end
end
