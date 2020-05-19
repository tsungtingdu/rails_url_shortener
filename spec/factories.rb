# frozen_string_literal: true

FactoryBot.define do
  factory :user do
    sequence(:email) { |n| "user#{n}@gmail.com" }
    password { '12345678' }
  end

  factory :url do
    long_url { 'https://www.amazon.com/' }
    short_url { 'akpitd' }
    count { 0 }
  end
end
