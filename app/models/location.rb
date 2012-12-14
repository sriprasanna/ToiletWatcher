class Location < ActiveRecord::Base
  attr_accessible :name
  has_many :stats

  def to_param
    name
  end
end
