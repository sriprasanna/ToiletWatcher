namespace :twitter do
  desc "Load data from Twitter Stream"
  task :load => :environment do
    URL   = "http://api.twitter.com/1/statuses/user_timeline.json?include_entities=true&include_rts=true&screen_name=SanHackTwToilet&count=100"
    REGEX = /^(?<toilet_count>\d+) people used the toilet and (?<wash_basin_count>\d+) people washed their hands.*$/

    location = Location.find_by_name 'SANHACK2012'
    location ||= Location.create name: 'SANHACK2012', latitude: 0.322985, longitude: 32.576576, description: 'Sanitation Hackathon'
    location.stats.delete_all

    resp = Net::HTTP.get_response(URI.parse(URL))
    data = resp.body
    results = JSON.parse(data)
    results.each do |result|
      matches = REGEX.match result['text']
      next if matches.nil?

      tweet = {
        time: result['created_at'],
        toilet_count: matches[:toilet_count].to_i,
        wash_basin_count: matches[:wash_basin_count].to_i,
        water_level: 0
      }

      stats    = location.stats.build(
        :time => Date.parse(tweet[:time]),
        :toilet_count => tweet[:toilet_count],
        :wash_basin_count => tweet[:wash_basin_count],
        :water_level => tweet[:water_level]
      )

      stats.save!
    end
  end
end
