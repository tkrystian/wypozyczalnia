class OrdersController < ApplicationController
  before_filter :authenticate_user!, only: [:new, :show, :finalize, :watch]
  before_action :set_order, only: [ :edit, :update, :destroy]

  # GET /orders
  # GET /orders.json
  def index
    @orders = Order.all
  end

  def finalize
    @user = User.find(current_user.id)
    @payment = params[:sum]


  end

  def watch
    user = User.find(current_user.id)
    orders = user.orders.where("status = true")
    movies_list = nil
    orders.each do |order|
      movies_list = order.movie_id if order.movie_id == params[:movie]
    end
    @movie = Movie.find(params[:movie])

  end

  def watchlist
    user = User.find(current_user.id)
    orders = user.orders
    if params[:status] == "OK"
      orders.each do |order|
        order.update_attribute(:status, true)
      end
      session[:orders_count] = 0
      session[:orders_sum] = 0
    end
    orders = user.orders.where("status = true")
    movies_ids = []
    orders.each do |order|
      movies_ids << order.movie_id
    end
    @movies = Movie.find(movies_ids)
  end

  def delegate_transaction

    user = User.find(current_user.id)
    orders = user.orders





    redirect_to show_orders_path, notice: 'Zapłaciłeś za filmy, gratulacje!'
  end

  # GET /orders/1
  # GET /orders/1.json
  def show

    @user = User.find(current_user.id)
    @orders = @user.orders

    session[:orders_sum] = @user.orders.where("status = false").sum("sum")
  end

  # GET /orders/new
  def new
    @order = Order.new
    @movie = Movie.find(params[:id])
  end

  # GET /orders/1/edit
  def edit
  end

  # POST /orders
  # POST /orders.json
  def create
    @order = Order.new(order_params)


    respond_to do |format|
      if @order.save
        format.html { redirect_to root_path, notice: 'Order was successfully created.' }
        format.json { render :show, status: :created, location: @order }
      else
        format.html { render :new }
        format.json { render json: @order.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /orders/1
  # PATCH/PUT /orders/1.json
  def update
    respond_to do |format|
      if @order.update(order_params)
        format.html { redirect_to @order, notice: 'Order was successfully updated.' }
        format.json { render :show, status: :ok, location: @order }
      else
        format.html { render :edit }
        format.json { render json: @order.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /orders/1
  # DELETE /orders/1.json
  def destroy

    session[:orders_count] -= 1

    @order.destroy
    respond_to do |format|
      format.html { redirect_to show_orders_path(current_user.id), notice: 'Order was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_order
      @order = Order.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def order_params
      params[:order].permit(:price, :user_id, :movie_id, :sum)
    end
end
