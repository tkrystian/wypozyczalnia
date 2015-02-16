class CreateWatchables < ActiveRecord::Migration
  def change
    create_table :watchables do |t|
      t.integer :user_id

      t.string :movie_id

      t.timestamps null: false
    end
  end
end
