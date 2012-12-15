class Location < ActiveRecord::Base
  attr_accessible :name, :latitude, :longitude, :description
  has_many :stats

  def to_param
    name
  end

  def today_stats
    stats.today.first
  end

end
