class CreateAdventures < ActiveRecord::Migration
  def change
    create_table :adventures do |t|
      t.text :activity
      t.datetime :date
      t.decimal :duration
      t.text :maps
      t.text :misc_notes

      t.timestamps
    end
  end
end
