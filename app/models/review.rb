class Review < ActiveRecord::Base
  validates :rating, numericality: { only_integer: true, greater_than_or_equal_to: 1, less_than_or_equal_to: 6 }
  belongs_to :user
  belongs_to :movie, counter_cache: true
end
