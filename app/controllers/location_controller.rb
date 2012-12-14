class LocationController < ApplicationController
  def create
    @location = Location.find_or_create_by_name(params[:name])
    stat = @location.stats.build( :time => Date.parse(params[:time]),
                                  :toilet_count => params[:toilet_count],
                                  :wash_basin_count => params[:wash_basin_count],
                                  :water_level => params[:water_level])
    stat.save!

    head :ok
  end

  def index
    @locations = Location.all
  end

  def show
    @location = Location.find_by_name(params[:id])
  end
end
