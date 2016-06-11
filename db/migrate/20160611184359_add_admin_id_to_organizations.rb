class AddAdminIdToOrganizations < ActiveRecord::Migration[5.0]
  def change
    add_reference :organizations, :admin
  end
end
