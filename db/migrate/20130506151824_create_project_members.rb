class CreateProjectMembers < ActiveRecord::Migration
  def change
    create_table :project_members do |t|
      t.references :user, null: false, index: true
      t.references :project, null: false, index: true
      t.boolean :owner, null: false, default: false
      t.timestamps
    end
  end
end
