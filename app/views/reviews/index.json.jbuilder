json.array!(@reviews) do |review|
  json.extract! review, :id, :movie_id, :user_id, :description
  json.url review_url(review, format: :json)
end
