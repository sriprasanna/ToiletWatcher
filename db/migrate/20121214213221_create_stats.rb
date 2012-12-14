class CreateStats < ActiveRecord::Migration
  def change
    create_table :stats do |t|
      t.integer :location_id
      t.integer :toilet_count
      t.integer :wash_basin_count
      t.integer :water_level
      t.datetime :time

      t.timestamps
    end
  end
end
