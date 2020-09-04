require 'faker'

FactoryBot.define do
    factory :director do
        name { Faker::Name.name }
        age { rand(60) + 20 }
    end
end