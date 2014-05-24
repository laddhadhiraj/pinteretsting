class AddStripTokenToOrders < ActiveRecord::Migration
  def change
    add_column :orders, :strip_token, :string
  end
end
