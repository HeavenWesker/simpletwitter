FactoryGirl.define do
  factory :user do
    sequence(:name) { |n| "user #{n}" }
    sequence(:id_name) { |n| "user_#{n}" }
    sequence(:email) { |n| "user_#{n}@example.com" }
    password  "Heaven"
    password_confirmation   "Heaven"
    factory :admin do
      admin true
    end
  end
  factory :micropost do
    content "Test Test Test"
    user
  end
end
