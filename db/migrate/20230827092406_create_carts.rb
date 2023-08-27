class CreateCarts < ActiveRecord::Migration[7.0]
  def change
    create_table :carts do |t|
      t.integer :quantity
      t.references :book, null: false, foreign_key: true
      t.references :member, null:false,foreign_key: true
      t.timestamps
    end
  end
end
