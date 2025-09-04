FactoryBot.define do
  factory :user do
    name  { "Alice #{SecureRandom.hex(4)}" }
    email { "alice_#{SecureRandom.hex(4)}@example.com" }
  end
end
