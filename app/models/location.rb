class Location < ActiveRecord::Base
  attr_accessible :name, :latitude, :longitude, :description
  has_many :stats

  def to_param
    name
  end

  def today_stats
    data = { toilet_count: 0, wash_basin_count: 0, water_level: 0 }
    stats.today.reduce(data) do |data, stat|
      data[:toilet_count] = data[:toilet_count] + stat.toilet_count
      data[:wash_basin_count] = data[:wash_basin_count] + stat.wash_basin_count
      data[:water_level] = stat.water_level
      data
    end
  end

end
