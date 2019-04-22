FactoryBot.define do
  factory :user do |user|

    user.sequence(:name) { |n| "bob#{n}"}
    email {'bobby@sq.com'}
  
  end
end