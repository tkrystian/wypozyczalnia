class AddMovieUrlToMovies < ActiveRecord::Migration
  def change
    add_column :movies, :movie_url, :string
  end
end
