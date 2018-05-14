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

    file_path = Rails.root.join('db', 'seed', 'shops_and_products.yml')
    @file     = YAML.load_file(file_path)

    @file.each do |model_name, records|
      @updated, @created, @deleted = 0, 0, 0

      model_name = model_name.classify.constantize

      records.each do |record|
        record = OpenStruct.new(record).to_h
        existing_record = model_name.where(id: record[:id]).first

        existing_record ? update_record(existing_record, record) : create_record(model_name, record)
      end

      puts "Справочник #{model_name} загружен. \tОбновлено: #{@updated} \tCоздано: #{@created} \tУдалено: #{@deleted}"
    end
  end
end
