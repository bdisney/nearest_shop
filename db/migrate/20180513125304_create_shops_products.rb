class CreateShopsProducts < ActiveRecord::Migration[5.0]
  def change
    create_join_table :shops, :products do |t|
      t.index :shop_id
      t.index :product_id
    end
  end
end
