class ChargesController < ApplicationController
  #before_action :set_charge, only: %i[ create edit update ]

    def index
        @charges = Charge.all
    end

    def new
    end
    def edit
    end
    def show
    end
    
    def create
        @charge = Charge.new(charge_params)
       respond_to do |format|
      if @charge.save
        format.html { redirect_to charge_url(@charge)}
       # format.json { render :show, status: :created, location: @charge }
       else
        format.html { render :edit, status: :unprocessable_entity }
       # format.json { render json: @charge.errors, status: :unprocessable_entity }
      end
    end
    end

    def update
      respond_to do |format|
        if @charge.update(charge_params)
          format.html { redirect_to charge_url(@charge), notice: "charge was successfully updated." }
        else
          format.html { render :show, status: :unprocessable_entity }
        end  
      end
        
    end    
end
private
    
    def set_charge
     @charge = Charge.find(params[:id])
    end

    
    def charge_params
      
      params.require(:charge).permit(:vehicle_type, :min_hours, :min_charge, :extra_hour_charges)
      binding.pry
    end


