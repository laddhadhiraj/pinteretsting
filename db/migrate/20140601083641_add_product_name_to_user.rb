class AddProductNameToUser < ActiveRecord::Migration
  def change
    add_column :users, :product_name, :string, :default => "free"
  end
end
