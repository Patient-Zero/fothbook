class CreateProfileTable < ActiveRecord::Migration
  def change
  	create_table :profile do |table|
      table.string :fname
      table.string :lname
      table.string :location
      table.string :bio
      table.integer :user_id
      table.timestamps
  	end
  end
end
