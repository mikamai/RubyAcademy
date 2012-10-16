class CreateTodos < ActiveRecord::Migration
  def change
    create_table :todos do |t|
      t.string :name
      t.boolean :completed, :default => false
      t.references :list

      t.timestamps
    end
  end
end
