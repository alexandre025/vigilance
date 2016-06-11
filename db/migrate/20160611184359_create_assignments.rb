class CreateAssignments < ActiveRecord::Migration[5.0]
  def change
    create_table :assignments do |t|
      t.belongs_to :user, index: true
      t.belongs_to :organization, index: true
      t.boolean :is_admin
      t.timestamps
    end
  end
end
