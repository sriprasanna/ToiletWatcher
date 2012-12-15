class Stat < ActiveRecord::Base
  attr_accessible :location, :location_id, :time, :toilet_count, :wash_basin_count, :water_level
  belongs_to :location

  default_scope order(:time)
  scope :today, lambda { where('time >= ? and time < ?', Date.today.to_datetime, Date.tomorrow.to_datetime) }
end
