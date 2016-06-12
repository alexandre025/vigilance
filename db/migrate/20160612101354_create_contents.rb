class CreateContents < ActiveRecord::Migration[5.0]
  def change
    create_table :contents do |t|
      t.string :title
      t.text :description
      t.text :comment
      t.string :source
      t.belongs_to :user
      t.belongs_to :organization
      t.timestamps
    end
  end
end
