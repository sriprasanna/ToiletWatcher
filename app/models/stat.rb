class Stat < ActiveRecord::Base
  attr_accessible :location, :location_id, :time, :toilet_count, :wash_basin_count, :water_level
  belongs_to :location

  default_scope order(:time)
  scope :today, lambda { where('time >= ? and time < ?', Date.today.to_datetime, Date.tomorrow.to_datetime) }

  def wash_level
    (wash_basin_count.to_f / toilet_count.to_f * 100.0) rescue 0
  end

  def alert_water_level?
    water_level < 30 rescue false
  end

  def alert_wash_level?
    wash_level > 0 and wash_level < 50 rescue false
  end
end
