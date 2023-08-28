class RenameRoleColumnInmember < ActiveRecord::Migration[7.0]
  def change
    rename_column :members, :role, :type
  end
end
