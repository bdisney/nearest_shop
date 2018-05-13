class CreateShops < ActiveRecord::Migration[5.0]
  def change
    create_table :shops do |t|
      t.string :city
      t.string :street
      t.string :zip

      t.float  :latitude,  index: true
      t.float  :longitude, Index: true

      t.timestamps null: false
    end
  end
end
