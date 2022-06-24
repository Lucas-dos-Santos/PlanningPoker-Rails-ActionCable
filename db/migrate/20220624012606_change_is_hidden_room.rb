class ChangeIsHiddenRoom < ActiveRecord::Migration[6.1]
  def change
    change_column :rooms, :is_hidden, :boolean, default: true
  end
end
