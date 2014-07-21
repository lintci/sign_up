class AddEmailIndexToVisitors < ActiveRecord::Migration
  def change
    add_index :visitors, :email
  end
end
