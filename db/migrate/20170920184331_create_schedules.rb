class CreateSchedules < ActiveRecord::Migration[5.1]
  def change
    create_table :schedules do |t|
      t.integer :user_id
      t.datetime :date

      t.timestamps
    end
  end
end
