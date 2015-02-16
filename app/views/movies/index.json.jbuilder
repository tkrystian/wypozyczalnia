json.array!(@movies) do |movie|
  json.extract! movie, :id, :title, :description, :rating, :cast
  json.url movie_url(movie, format: :json)
end
