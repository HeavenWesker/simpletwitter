#FactoryGirl.define do
#  factory :user do
#    name      "Heaven"
#    email     "Heaven.Wesker@gmail.com"
#    password  "Heaven"
#    password_confirmation   "Heaven"
#  end
#end
FactoryGirl.define do
  factory :user do
    sequence(:name) { |n| "user #{n}" }
    sequence(:email) { |n| "user_#{n}@example.com" }
    password  "Heaven"
    password_confirmation   "Heaven"
    factory :admin do
      admin true
    end
  end
end
