FactoryBot.define do
  factory :shop do
    city   'Moscow'
    street 'Some street, 42'
    zip    '123456'

    trait :default do
      default_for_all true
    end
  end
end
