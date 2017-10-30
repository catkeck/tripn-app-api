class CreateInterests < ActiveRecord::Migration[5.1]
  def change
    create_table :interests do |t|
      t.string :interest

      t.timestamps
    end
  end
end
