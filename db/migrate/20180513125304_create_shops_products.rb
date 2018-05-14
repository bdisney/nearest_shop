class CreateShopsProducts < ActiveRecord::Migration[5.0]
  def change
    create_table :products_shops do |t|
      t.belongs_to :shop,    index: true
      t.belongs_to :product, index: true

      t.decimal :price, precision: 12, scale: 1

      t.timestamps null: false
    end
  end
end
