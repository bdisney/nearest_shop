class AddDefaultColumnToShops < ActiveRecord::Migration[5.0]
  def change
    add_column :shops, :default_for_all, :boolean, default: false
  end
end
