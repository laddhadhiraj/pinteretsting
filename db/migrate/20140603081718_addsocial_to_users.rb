class AddsocialToUsers < ActiveRecord::Migration
  def change
  	add_column :users, :instagram_token, :string
  	add_column :users, :facebook_token, :string
  	add_column :users, :twitter_token, :string
  end
end
