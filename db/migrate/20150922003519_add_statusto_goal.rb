class AddStatustoGoal < ActiveRecord::Migration
  def change
    add_column :goals, :status, :string, default: 'incomplete'
  end
end
