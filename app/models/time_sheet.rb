class TimeSheet < ApplicationRecord
  include Hashidable
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

  def line_items_attributes=(attributes)
    attributes.each do |attr|
      if attr['hashid'].present?
        li = line_items.find_by_hashid!(attr['hashid'])
        li.assign_attributes(attr.except('hashid'))
      else
        line_items.build(attr)
      end
    end
  end

  def as_json(options = {})
    json = super(options)
    json['id'] = hashid
    json
  end

  def serializable_hash(options = nil)
    hash = super(options)
    hash['id'] = hashid
    hash
  end
end
