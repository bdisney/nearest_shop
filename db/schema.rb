# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your
# database schema. If you need to create the application database on another
# system, you should be using db:schema:load, not running all the migrations
# from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 20180513125304) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "products", force: :cascade do |t|
    t.string   "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "products_shops", force: :cascade do |t|
    t.integer  "shop_id"
    t.integer  "product_id"
    t.decimal  "price",      precision: 12, scale: 2
    t.datetime "created_at",                          null: false
    t.datetime "updated_at",                          null: false
    t.index ["product_id"], name: "index_products_shops_on_product_id", using: :btree
    t.index ["shop_id"], name: "index_products_shops_on_shop_id", using: :btree
  end

  create_table "shops", force: :cascade do |t|
    t.string   "city"
    t.string   "street"
    t.string   "zip"
    t.float    "latitude"
    t.float    "longitude"
    t.boolean  "default_for_all", default: false
    t.datetime "created_at",                      null: false
    t.datetime "updated_at",                      null: false
    t.index ["latitude"], name: "index_shops_on_latitude", using: :btree
  end

end
