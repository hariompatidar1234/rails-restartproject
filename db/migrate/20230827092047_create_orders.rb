class CreateOrders < ActiveRecord::Migration[7.0]
  def change
    create_table :orders do |t|
      t.integer :quantity
      t.references :book, null: false, foreign_key: true
      t.references :cart, null: false, foreign_key:  true 
      t.references :member, null:false,foreign_key: true
      t.timestamps
    end
  end
end
