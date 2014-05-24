class AddAllowedPinToUsers < ActiveRecord::Migration
  def change
    add_column :users, :allowed_pins, :integer, :default => 10
  end
end
