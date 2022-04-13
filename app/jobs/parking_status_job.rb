class ParkingStatusJob < ApplicationJob


  def perform
    change_status
  end

  def change_status
    @vehicles = Vehicle.where(status: "Parked")
    @vehicles.each do | vehicle|
       time = ((Time.now - vehicle.in_time)/60).ceil
      if time > 1440
          vehicle.status = "Issue"
      end
    end
  end
end
