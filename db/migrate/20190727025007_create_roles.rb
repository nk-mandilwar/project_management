class CreateRoles < ActiveRecord::Migration[5.2]
  def change
    create_table :roles do |t|
      t.string :description
      t.string :internal_identifier

      t.timestamps
    end
  end
end
