FactoryBot.define do
  factory :shop do
    city   'Moscow'
    street 'Some street, 42'
    zip    '123456'

    trait :default do
      default_for_all true
    end

    trait :invalid do
      city nil
    end

    trait :with_nested_attrs do

      before(:create) do |shop, evaluator|
        create(:products_shop, shop: shop, product: create(:product))

      end
    end
  end
end
