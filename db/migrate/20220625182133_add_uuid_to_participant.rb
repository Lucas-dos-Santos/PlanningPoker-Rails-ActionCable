class AddUuidToParticipant < ActiveRecord::Migration[6.1]
  def change
    add_column :participants, :uuid, :string, unique: true
  end
end
