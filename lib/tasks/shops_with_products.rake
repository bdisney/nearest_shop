namespace :shops_with_products do
  task seed: :environment do
    def update_record(existing_record, attributes)
      existing_record.update(attributes)
      @updated += 1
    end

    def create_record(model_name, record)
      model_name.create(record)
      @created += 1
    end

    def create_shops_and_products
      @file.each do |model_name, records|
        @updated, @created = 0, 0
        model_name = model_name.classify.constantize

        records.each do |attrs|
          attrs = OpenStruct.new(attrs).to_h
          existing_record = model_name.where(attrs).first
          existing_record ? update_record(existing_record, attrs) : create_record(model_name, attrs)
        end
      puts "Справочник #{model_name} загружен. \tОбновлено: #{@updated} \tCоздано: #{@created}"
      end
    end

    def add_products_to_shop(shop)
      Product.first(3).each do |product|
        return if ProductsShop.where(shop_id: shop, product_id: product).present?
        shop.products_shops.create(price: rand(10.01..999.99), product_id: product.id)
      end
    end

    file_path = Rails.root.join('db', 'seed', 'shops_and_products.yml')
    @file     = YAML.load_file(file_path)

    create_shops_and_products
    Shop.first(3).each { |shop| add_products_to_shop(shop) }
  end
end
