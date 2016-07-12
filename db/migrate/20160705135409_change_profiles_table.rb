class ChangeProfilesTable < ActiveRecord::Migration
  def change
  		change_column(:profile, :user_id, :integer)
  end
end
