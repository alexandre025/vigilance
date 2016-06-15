class CreateContentsSaved < ActiveRecord::Migration[5.0]
  def change
    create_table :contents_saveds do |t|
      t.belongs_to :user
      t.belongs_to :content
      t.string :relation
    end

    drop_table :follows
  end
end
