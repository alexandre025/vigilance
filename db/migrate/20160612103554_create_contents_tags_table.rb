class CreateContentsTagsTable < ActiveRecord::Migration[5.0]
  def change
    create_table :contents_tags do |t|
      t.belongs_to :content
      t.belongs_to :tag
    end
  end
end
