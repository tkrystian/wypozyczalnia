class WelcomeController < ApplicationController
  def index
    @movies = Movie.order("rating DESC").limit(5)
    @most_ordered = Movie.order("orders_count DESC").limit(5)
    @most_reviewd = Movie.order("reviews_count DESC").limit(5)

    if current_user
      @user = User.find(current_user.id)
      orders_count = @user.orders.where("status = false").count
      session[:orders_count] = orders_count
      session[:orders_sum] = @user.movies.sum("price")

    end
  end
end
