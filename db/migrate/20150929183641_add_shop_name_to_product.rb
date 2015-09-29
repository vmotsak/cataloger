class AddShopNameToProduct < ActiveRecord::Migration
  def change
    add_column :products, :shop_name, :string
  end
end
