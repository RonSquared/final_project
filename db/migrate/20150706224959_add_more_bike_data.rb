class AddMoreBikeData < ActiveRecord::Migration
  def change
  	add_column :adventures, :distance, :string 
  	add_column :adventures, :moving_time, :integer
  	add_column :adventures, :total_elevation_gain, :integer
  	add_column :adventures, :elapsed_time, :integer
  	add_column :adventures, :location_city, :string
  	add_column :adventures, :location_state, :string
  	add_column :adventures,	:location_country, :string
  end
end
