class AddProToProducts < ActiveRecord::Migration
  def change
    add_column :products, :is_pro, :boolean
  end
end
