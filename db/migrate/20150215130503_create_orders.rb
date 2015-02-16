class CreateOrders < ActiveRecord::Migration
  def change
    create_table :orders do |t|
      t.belongs_to :user, index: true
      t.float :sum
      t.belongs_to :movie, index: true

      t.timestamps null: false
    end
  end
end
