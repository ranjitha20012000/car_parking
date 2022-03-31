class VehiclesController < ApplicationController
    before_action :set_vehicle, only: [:show, :edit, :update]

    before_action :get_charge, only: [:create]

    #before_action :check_if_admin
     def index
        @vehicles = Vehicle.all
      end
    
      
    
      def new
        @vehicle = Vehicle.new
      end
    
      def edit
      end
    
     def create
        @vehicle = Vehicle.new(vehicle_params)
        @vehicle.status = Vehicle::STATUS[:Parked]
        @vehicle.in_time= Time.now
        @vehicle.user_id = current_user.id
        @vehicle.charge_id = @charge.id
        respond_to do |format|
          if @vehicle.save
            redirect_to vehicles_path
            #format.json { render :show, status: :created, location: @vehicle }
          else
            flash[:notice] =@vehicle.errors.full_messages&.join(', ')
            render :new 
            #format.json { render json: @vehicle.errors, status: :unprocessable_entity }
          end
        end
     end
    
      def update
        respond_to do |format|
          if @vehicle.update(vehicle_params)
             redirect_to @vehicle, notice: 'Vehicle was successfully updated.' 
            
          else
            render :edit 
          end
        end
      end
    
     def show
        
     end  
    
    
      private
    
      #def check_if_admin
        #redirect_to root_path unless current_user.is_admin?
      #end
    
      # Use callbacks to share common setup or constraints between actions.
      def set_vehicle
        
        @vehicle = Vehicle.find(params[:id])
      end
    
      # Only allow a list of trusted parameters through.
      def vehicle_params
        params.require( :vehicle).permit(:number, :name_or_mobile)
      end

      def get_charge
        @charge = Charge.find_by_vehicle_type(params[:vehicle][:vehicle_type])
      end
    
end