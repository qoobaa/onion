class CreateOrders < ActiveRecord::Migration[7.0]
  def change
    create_table :orders do |t|
      t.belongs_to :user
      t.string :uid
      t.date :date
      t.decimal :total, precision: 8, scale: 2
      t.string :description

      t.timestamps
    end
    add_index :orders, [:user_id, :uid], unique: true
  end
end
