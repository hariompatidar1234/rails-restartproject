class CreateMembers < ActiveRecord::Migration[7.0]
  def change
    create_table :members do |t|
      t.string :name
      t.string :address
      t.string :email
      t.string :password
      t.string :contact
      t.string :type

      t.timestamps
    end
  end
end
