class ChangingColumns < ActiveRecord::Migration
  def change
  	
  	change_column :adventures, :moving_time, :decimal
  	change_column :adventures, :total_elevation_gain, :decimal
  	
  	remove_column :adventures, :elapsed_time
  	remove_column :adventures, :maps

  	add_column :adventures, :title, :string

  end
end
