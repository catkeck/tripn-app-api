class AddImageUrlToSchedules < ActiveRecord::Migration[5.1]
  def change
    add_column :schedules, :image_url, :string
  end
end
