class AddLocationToSchedules < ActiveRecord::Migration[5.1]
  def change
    add_column :schedules, :location, :string
  end
end
