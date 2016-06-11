class AddOrganizartionIdToTags < ActiveRecord::Migration[5.0]
  def change
    add_reference :tags, :organization
  end
end
