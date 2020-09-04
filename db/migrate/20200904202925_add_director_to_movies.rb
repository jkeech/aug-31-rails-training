class AddDirectorToMovies < ActiveRecord::Migration[6.0]
  def change
    remove_column :movies, :director
    add_reference :movies, :director, index: true
  end
end
