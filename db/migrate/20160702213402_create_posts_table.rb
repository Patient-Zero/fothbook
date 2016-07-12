class CreatePostsTable < ActiveRecord::Migration
  def change
  	    create_table :posts do |table|
      table.string :subject
      table.string :content
      table.timestamps
  	end
  end
end
