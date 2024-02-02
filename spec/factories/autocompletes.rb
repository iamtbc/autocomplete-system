FactoryBot.define do
  factory :autocomplete do
    query { "MyString" }
    candidates { "" }
  end
end
