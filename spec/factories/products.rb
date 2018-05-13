FactoryBot.define do
  factory :product do
    name 'Some name'

    trait :invalid do
      name nil
    end
  end
end
