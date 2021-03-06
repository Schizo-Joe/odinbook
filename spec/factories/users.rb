FactoryBot.define do
  factory :user do
    sequence :email do |n|
      "foo#{n}@bar.com"
    end
    sequence :name do |n|
      "foobar#{n}"
    end
    password { 'foobar' }
    password_confirmation { 'foobar' }

    summary { Faker::Lorem.paragraph }

    trait :from_discord do
      provider { 'discord' }
      uid { '123456789' }
    end

    transient do
      confirmed { true }
    end

    after :create do |user, options|
      user.confirm if options.confirmed
    end
  end
end
