class AddColorFormatToMovies < ActiveRecord::Migration[6.0]
  def change
    add_column :movies, :color_format, :integer
  end
end
