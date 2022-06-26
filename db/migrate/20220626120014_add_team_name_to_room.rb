class AddTeamNameToRoom < ActiveRecord::Migration[6.1]
  def change
    add_column :rooms, :team_name, :string
  end
end
