FactoryBot.define do
  factory :post do
    title { "Test Title" }
    body { "Test body test body test body!!!" }
    association :user
  end
end
