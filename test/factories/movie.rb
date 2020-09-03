require 'faker'

FactoryBot.define do
    factory :movie do
        title { Faker::Movie.title }
        year { Faker::Date.between(from: 20.years.ago, to: Date.today).year }
        director { Faker::Name.name }
        plot_keywords { Faker::Lorem.words.join('|') }
        facebook_likes { Faker::Types.rb_integer }
    end
end