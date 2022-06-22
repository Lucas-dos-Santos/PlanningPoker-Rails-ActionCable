class AddRoomAndParticipants < ActiveRecord::Migration[6.1]
  def change
    create_table :rooms do |t|
      t.string :unique_identifier
      t.integer :participants_count
      t.boolean :is_hidden

      t.timestamps
    end

    create_table :participants do |t|
      t.references :room, null: false, foreign_key: true
      t.string :user_session_id
      t.string :name
      t.integer :estimate

      t.timestamps
    end
  end
end
