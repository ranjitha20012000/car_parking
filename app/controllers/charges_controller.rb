class ChargesController < ApplicationController
    def index
        @charges = Charge.all.order(id: :desc)
    end
    def edit
      @charge = Charge.find(params[:id])
    end
    def new
      @charge = Charge.new
    end
    def create
      
      @charge = Charge.new(params.require(:charge).permit(:vehicle_type, :min_hours, :min_charge, :extra_hour_charges))  
       if @charge.save
         flash[:notice] = "Charge was successfully created!!"
         redirect_to charges_path(@charge)
        else
          flash[:notice] = @charge.errors.full_messages &.join(', ')
          render :new 
        end
      end
    def update
      @charge = Charge.find(params[:id])
      #respond_to do |format|
      if @charge.update(charge_params)
        #format.html { redirect_to @charge, notice: 'Successfully updated.' }
        #format.json { render :index, status: :ok, location: @charge }
        flash[:notice] = "Charge was successfully updated!"
        redirect_to charges_path(@charge)
        #redirect_to charges_url(@charges)
      else
        #format.html { render :edit }
        #format.json { render json: @charge.errors, status: :unprocessable_entity }
        flash.now[:error] = "Charge update failed"
        render :edit
       end     
    end   
end

private
    def charge_params 
      #params.require(:charge).permit(:vehicle_type, :min_hours, :min_charge, :extra_hour_charges)
      params.require(:charge).permit(:min_hours, :min_charge, :extra_hour_charges)
    end
