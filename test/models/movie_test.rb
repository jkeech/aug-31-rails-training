
require 'test_helper'
 
class MovieTest < ActiveSupport::TestCase
  test "movie is valid with a title" do
    movie = build(:movie, title: "Parasite")

    assert_equal "Parasite", movie.title
    assert movie.valid?
  end

  test "movie belongs to a director" do
    director = create(:director)
    movie = create(:movie, director: director)

    assert_equal director, movie.director
    assert movie.valid?
  end

  test "movie is invalid without a title" do
    movie = build(:movie, title: nil)
    refute movie.valid?
  end
  
  test "movie is invalid with empty title" do
    movie = build(:movie, title: "")
    refute movie.valid?
  end

  test "movie is valid with pipe-delimted keywords" do
    movie = create(:movie)
    
    refute_nil movie.plot_keywords
    assert movie.plot_keywords.include? '|'
    assert movie.valid?
  end

  test "count by likes does not count likes less than or equal to N" do
    movie = create(:movie, facebook_likes: 0)

    result = Movie.count_more_than_n_likes 1
    assert_equal 0, result
  end 
  
  test "count by likes counts likes greater than N" do
    movie = create(:movie, facebook_likes: 1)

    result = Movie.count_more_than_n_likes 0
    assert_equal 1, result
  end 

  test "titles finds all titles" do
    create(:movie)
    create(:movie)
    create(:movie)

    result = Movie.titles
    assert_equal 3, result.count
  end

  test "movies by director after 2010 finds correct movies" do
    movie_1 = create(:movie, year: "2011")
    movie_2 = create(:movie, year: "2020", director: movie_1.director)

    result = Movie.movies_by_director_after_2010 movie_1.director
    assert_equal [movie_1, movie_2], result
  end

  test "movies by director after 2010 does not find older movies" do
    movie_1 = create(:movie, year: "2010")
    movie_2 = create(:movie, year: "1999", director: movie_1.director)

    result = Movie.movies_by_director_after_2010 movie_1.director
    assert_equal 0, result.count
  end

  test "movies by director after 2010 does not find movies from the wrong director" do
    correct_director = create(:director)
    wrong_director = create(:director)
    movie_1 = create(:movie, director: wrong_director, year: "2020")
    movie_2 = create(:movie, director: wrong_director , year: "2020")

    result = Movie.movies_by_director_after_2010 correct_director
    assert_equal 0, result.count
  end

  test "color format methods" do
    movie = create(:movie)
    movie.color!

    assert movie.color?, "should be color"
    refute movie.black_and_white?, "should not be black and white"
    assert_equal "color", movie.color_format

    movie.black_and_white!

    assert movie.black_and_white?, "should be black and white"
    refute movie.color?, "should not be color"

    assert_equal "black_and_white", movie.color_format
  end

  test "is_in methods" do
    movie = create(:movie)
    movie.color!

    assert movie.is_in_color?, "should be color"
    refute movie.is_in_black_and_white?, "should not be black and white"

    movie.black_and_white!

    assert movie.is_in_black_and_white?, "should be black and white"
    refute movie.is_in_color?, "should not be color"
  end
end