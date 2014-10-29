FactoryGirl.define do
  factory :user, :class => User do
    sequence(:login){|n| "user#{SecureRandom.hex}_#{n}"}
    sequence(:email){|n| "user_#{n}@ya.ru"}
    password "1"
    active true
  end
end