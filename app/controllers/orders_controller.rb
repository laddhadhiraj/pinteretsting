class OrdersController < ApplicationController
  before_action :set_order, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_user!
  # GET /orders
  # GET /orders.json
  def index
    if current_user.product_name == 'gold'
      redirect_to root_path
    end 
    @order = Order.new
  end

  # GET /orders/1
  # GET /orders/1.json
  def show
  end

  # GET /orders/new
  def new

    if current_user.product_name == 'gold'
      redirect_to root_path
    end 

    @order = Order.new
  end

  # GET /orders/1/edit
  def edit
  end

  # POST /orders
  # POST /orders.json
  def create
    if current_user.product_name == 'gold'
      redirect_to root_path
    end 

    @order = current_user.orders.build(order_params)

    respond_to do |format|
      if @order.save
        
        if order_params[:product] == '$25 - Gold Plan'
          add_pin = 100
          plan = 'gold'
        else
           add_pin = 25
           plan = 'silver'
        end
            
        #Increase User pin on successfully payment recevied
        user = User.find(current_user.id)
        user.allowed_pins += add_pin
        user.product_name = plan
        user.save()

        format.html { redirect_to edit_user_registration_path, notice: 'Your Payment successfully received.' }
        # format.json { render :show, status: :created, location: @order }
      else
        format.html { render :new }
        # format.json { render json: @order.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /orders/1
  # PATCH/PUT /orders/1.json
  def update
 
  end

  # DELETE /orders/1
  # DELETE /orders/1.json
  def destroy
 
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_order
      @order = Order.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def order_params
      params.require(:order).permit(:strip_token, :strip_response, :product)
    end
end
