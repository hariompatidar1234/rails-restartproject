class CreateRatings < ActiveRecord::Migration[7.0]
  def change
    create_table :ratings do |t|
      t.integer :rate
      t.text :comment
      t.references :book, null: false, foreign_key: true
      t.references :member, null: false,foreign_key: true
      # t.references :member, null: false,foreign_key: true
      t.timestamps
    end
  end
end
