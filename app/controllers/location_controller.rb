class LocationController < ApplicationController
  def create
    @location = Location.find_or_create_by_name(params[:name])
    time = DateTime.parse(params[:time])
    if stat = @location.stats.last and stat.time.strftime("%D") == time.strftime("%D")
      stat.update_attributes!( :toilet_count => params[:toilet_count],
                              :wash_basin_count => params[:wash_basin_count],
                              :water_level => params[:water_level])
    else
      stat = @location.stats.build( :time => time,
                                    :toilet_count => params[:toilet_count],
                                    :wash_basin_count => params[:wash_basin_count],
                                    :water_level => params[:water_level])
      stat.save!
    end

    head :ok
  end

  def index
    @locations = Location.all
  end

  def show
    @location = Location.find_by_name(params[:id])
    @stats = @location.stats.order("time DESC")
  end
end
