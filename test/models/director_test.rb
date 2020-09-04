require 'test_helper'

class DirectorTest < ActiveSupport::TestCase
    test "director has a name and age" do
        director = create(:director, name: "Bong Joon-ho", age: 50)

        assert_equal director.name, "Bong Joon-ho"
        assert_equal director.age, 50
        assert director.valid?
    end

    test "director has many movies" do
        director = create(:director)
        assert_equal director.movies.count, 0

        movies = create_list(:movie, 3, director: director)
        assert_equal director.movies.count, 3
        assert director.valid?
    end
end