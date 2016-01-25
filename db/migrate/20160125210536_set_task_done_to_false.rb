class SetTaskDoneToFalse < ActiveRecord::Migration
  def change
    change_column :tasks, :done, :boolean, null: false, default: false
  end
end
