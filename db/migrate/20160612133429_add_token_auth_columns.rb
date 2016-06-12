class AddTokenAuthColumns < ActiveRecord::Migration[5.0]
  def change
    add_column :assignments, :is_active, :boolean, default: false
    add_column :assignments, :assignment_token, :string
    add_column :users, :auth_token, :string
  end
end
