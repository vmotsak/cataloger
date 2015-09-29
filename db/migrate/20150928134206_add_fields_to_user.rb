class AddFieldsToUser < ActiveRecord::Migration
  def change
    add_column :users, :last_name, :string
    add_column :users, :avatar_id, :string
    add_column :users, :passport_photo_id, :string
    add_column :users, :shop_name, :string
    add_column :users, :role, :string
  end
end
