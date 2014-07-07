class PinsController < ApplicationController
  before_action :set_pin, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_user!, except: [:index, :show]
  before_action :correct_user, only: [:edit, :destroy]

  def index

    person0 = "Dhiraj"
    person1 = "Tim"
    person2 = person1
    
    person1[0] = "Jfdsfads"

    render json: person2


    @pins = Pin.all.order("created_at DESC").paginate(:page => params[:page], :per_page => 8)

    if user_signed_in?
      remaning_pins = current_user.allowed_pins - current_user.pins.length
      if remaning_pins <= 1000
          if current_user.product_name != 'gold'  
            flash[:notice] = "You have remaning pins only <strong>" +  remaning_pins.to_s() +"</strong>, please <a href='/orders'>Order</a> for more pin."
          else
            flash[:notice] = "You can add <strong>" +  remaning_pins.to_s() +"</strong> pins only."
          end
       end 
     end
  end

  def show
  end

  def new
    @pin = current_user.pins.build
  end

  def edit
  end

  def create
    if  current_user.allowed_pins > current_user.pins.length 
      @pin = current_user.pins.build(pin_params)
      if @pin.save
        redirect_to @pin, notice: 'Pin was successfully created.'
      else
        render action: 'new'
      end
     else
        redirect_to orders_path, notice: 'You can not add more pin, please buy more pins'
     end 
  end

  def update
    if @pin.update(pin_params)
      redirect_to @pin, notice: 'Pin was successfully updated.'
    else
      render action: 'edit'
    end
  end

  def destroy
    @pin.destroy
    redirect_to pins_url
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_pin
      @pin = Pin.find(params[:id])
    end

    def correct_user
      @pin = current_user.pins.find_by(id: params[:id])
      redirect_to pins_path, notice: "Not authorized to edit this pin" if @pin.nil?
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def pin_params
      params.require(:pin).permit(:description, :image, :crop_x, :crop_y, :crop_w, :crop_h)
    end
end
