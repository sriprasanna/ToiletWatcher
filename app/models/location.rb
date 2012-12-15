class Location < ActiveRecord::Base
  attr_accessible :name, :latitude, :longitude, :description
  has_many :stats

  def to_param
    name
  end

  def latest_stat
    stats.last
  end

  def map?
    latitude > 0 and longitude > 0 rescue false
  end

end
