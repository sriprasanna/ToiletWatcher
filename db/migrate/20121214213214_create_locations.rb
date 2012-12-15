class CreateLocations < ActiveRecord::Migration
  def change
    create_table :locations do |t|
      t.string :name
      t.string :description
      t.decimal :latitude
      t.decimal :longitude

      t.timestamps
    end
  end
end
