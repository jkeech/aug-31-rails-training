require 'faker'

FactoryBot.define do
    factory :movie do
        director
        title { Faker::Movie.title }
        year { Faker::Date.between(from: 20.years.ago, to: Date.today).year }
        plot_keywords { Faker::Lorem.words.join('|') }
        facebook_likes { Faker::Types.rb_integer }
        color_format { Movie.color_formats.values.sample }
    end
end