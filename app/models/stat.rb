class Stat < ActiveRecord::Base
  attr_accessible :location_id, :time, :toilet_count, :wash_basin_count, :water_level
  belongs_to :location
end
