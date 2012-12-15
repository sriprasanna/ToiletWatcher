# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

def populate_stats(location)
  time = Date.today.to_datetime
  water_level = 1000

  toilet_seed = (3..8).to_a
  wash_basin_seed = (2..5).to_a
  time_seed = (30..60).to_a
  water_level_seed = (1..15).to_a

  (1..100).each do
    time = time + time_seed.sample.minutes
    water_level = water_level - water_level_seed.sample
    Stat.create location: location, time: time, toilet_count: toilet_seed.sample, wash_basin_count: wash_basin_seed.sample, water_level: water_level
  end
end

populate_stats Location.create name: 'SANHACK2012', description: 'Sanitation Hackathon', latitude: 0.345244, longitude: 32.597626
populate_stats Location.create name: 'UNICEF', description: 'UNICEF Office', latitude: 0.318505, longitude: 32.576877
