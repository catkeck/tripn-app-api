class AddImageUrlToActivities < ActiveRecord::Migration[5.1]
  def change
    add_column :activities, :imageURL, :string
  end
end
