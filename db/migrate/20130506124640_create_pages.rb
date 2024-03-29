class CreatePages < ActiveRecord::Migration
  def change
    create_table :pages do |t|
      t.string :name, null: false
      t.text :objects
      t.references :project, index: true

      t.timestamps
    end
  end
end
