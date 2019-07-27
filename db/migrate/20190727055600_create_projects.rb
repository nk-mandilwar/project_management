class CreateProjects < ActiveRecord::Migration[5.2]
  def change
    create_table :projects do |t|
      t.string :name

      t.timestamps
    end
    add_index :projects, :name, unique: true
    add_reference :projects, :creator, index: true, foreign_key: true
  end
end
