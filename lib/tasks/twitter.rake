namespace :twitter do
  desc "Load data from Twitter Stream"
  task :load => :environment do
    URL   = "http://api.twitter.com/1/statuses/user_timeline.json?include_entities=true&include_rts=true&screen_name=SanHackTwToilet&count=10"
    REGEX = /^(?<toilet_count>\d+) people used the toilet and (?<wash_basin_count>\d+) people washed their hands.*$/
    last_parsed_ID = 0

    resp = Net::HTTP.get_response(URI.parse(URL))
    data = resp.body
    results = JSON.parse(data)
    results.reverse.each do |result|
      next if last_parsed_ID > result['id']
      matches = REGEX.match result['text']
      next if matches.nil?

      tweet = {
        time: result['created_at'],
        toilet_count: matches[:toilet_count].to_i,
        wash_basin_count: matches[:wash_basin_count].to_i,
        water_level: 0
      }

      location = Location.find_by_name 'MOA2012'
      location ||= Location.create name: 'MOA2012', latitude: 0.322985, longitude: 32.576576, description: 'MOA2012'
      stats    = location.stats.build(
        :time => Date.parse(tweet[:time]),
        :toilet_count => tweet[:toilet_count],
        :wash_basin_count => tweet[:wash_basin_count],
        :water_level => tweet[:water_level]
      )

      stats.save!
      last_parsed_ID = result['id']
    end
  end
end
