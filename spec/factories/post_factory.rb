FactoryGirl.define do
  factory :post, :class => Post do
    title "Заголовок"
    sequence(:text){|n| "Текст #{SecureRandom.hex}"}
    created_at { Time.now }
  end
end