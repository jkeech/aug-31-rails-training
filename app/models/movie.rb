class Movie < ApplicationRecord
    validates_presence_of :title

    enum color_format: [ :black_and_white, :color ]

    def self.count_more_than_n_likes(n)
        where("facebook_likes > ?", n).count
    end

    def self.titles
        pluck(:title)
    end

    def self.movies_by_director_after_2010(director)
       where(director: director).where('year > ?', "2010")
    end

    def self.movies_by_likes_descending
        order(facebook_likes: :desc)
    end

    def self.year_released(title)
        find_by(title: title)&.year
    end    
end