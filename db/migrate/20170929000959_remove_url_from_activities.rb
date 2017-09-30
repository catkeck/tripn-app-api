class RemoveUrlFromActivities < ActiveRecord::Migration[5.1]
  def change
    remove_column :activities, :url
  end
end
