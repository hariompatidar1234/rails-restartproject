class CreateBooks < ActiveRecord::Migration[7.0]
  def change
    create_table :books do |t|
      t.string :title
      t.string :author
      t.decimal :price, precision: 5, scale: 2
      t.integer :quantity, default: 0, null: false
      t.references :member, null:false,foreign_key: true
      t.timestamps
    end
     add_index :books, :title, unique: true
  end
end
