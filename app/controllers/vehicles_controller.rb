class VehiclesController < ApplicationController
    before_action :set_vehicle, only: [ :edit, :update, :release_action]
    
    before_action :get_charge, only: [:create]
    
    

    #before_action :check_if_admin
    def index
      #@vehicles=Vehicle.page(params[:page]).order(id: :desc)
      #@vehicles=Vehicle.order(id: :desc).paginate(page: params[:page], per_page: 10)
      @charge=Charge.all
      @q = Vehicle.ransack(params[:q])
      @vehicles = @q.result(distinct: true).paginate(page: params[:page], per_page: 10).order(id: :desc)
    end
    
    def new
      @vehicle = Vehicle.new
      @charge = Charge.find_by id: params["charge_id"]
    end
  
    def edit
    end
    
    def create
      @vehicle = Vehicle.new(vehicle_params)
      @vehicle.status = Vehicle::STATUS[:parked]
      @vehicle.in_time= Time.now
      @vehicle.user_id = current_user.id
      if @charge.present?
        @vehicle.charge_id = @charge&.id
      else
        @vehicle.errors.add(:charge, 'charge not available')
      end
        if @vehicle.save
          flash[:notice] = "Vehicle added successfully"
          redirect_to vehicles_path
          #format.json { render :show, status: :created, location: @vehicle }
        else
          flash[:notice] = @vehicle.errors.full_messages &.join(', ')
          render :new 
          #format.json { render json: @vehicle.errors, status: :unprocessable_entity }
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
    
    def release_action
      @vehicle.user_id = current_user.id
      @vehicle.out_time= Time.now
      @vehicle.status = Vehicle::STATUS[:left]
      @vehicle.total_time = ((@vehicle.out_time - @vehicle.in_time) / 60).round
      @vehicle.fees = @vehicle.calculate_fees
      if @vehicle.save
        flash[:notice] = "vehicle released successfully"
        #format.json { render :show, status: :created, location: @vehicle }
      else
        flash[:notice] = @vehicle.errors.full_messages &.join(', ')
      end
      redirect_to vehicles_path 
    end
    
    private
    
    #def check_if_admin
      #redirect_to root_path unless current_user.is_admin?
    #end
    
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
