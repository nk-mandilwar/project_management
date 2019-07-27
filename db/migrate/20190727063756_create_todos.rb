class CreateTodos < ActiveRecord::Migration[5.2]
  def change
    create_table :todos do |t|
      t.string :name

      t.timestamps
    end

    add_index :todos, :name, unique: true
    add_reference :todos, :project, index: true, foreign_key: true
    add_reference :todos, :creator, index: true, foreign_key: true
    add_reference :todos, :developer, index: true, foreign_key: true
  end
end
