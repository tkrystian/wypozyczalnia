class AddReviewCountToMovies < ActiveRecord::Migration
  def change
    add_column :movies, :orders_count, :integer, :default => 0

  end
end
