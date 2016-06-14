class AddImportanceToContents < ActiveRecord::Migration[5.0]
  def change
    add_column :contents, :importance, :integer
  end
end
