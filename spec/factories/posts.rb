FactoryBot.define do
  factory :post do
    title { "Test Post" }
    body { "Lorem ipsum etc. etc." }
    user { FactoryBot.create(:user) }
  end
end
