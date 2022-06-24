class AddCanEstimateToParticipant < ActiveRecord::Migration[6.1]
  def change
    add_column :participants, :can_estimate, :boolean, default: true
  end
end
