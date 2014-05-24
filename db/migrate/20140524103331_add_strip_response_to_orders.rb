class AddStripResponseToOrders < ActiveRecord::Migration
  def change
    add_column :orders, :strip_response, :string
  end
end
