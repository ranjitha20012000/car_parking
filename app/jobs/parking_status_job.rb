class ParkingStatusJob < ApplicationJob
 queue_as :default
  def perform
    change_status
  end
  def change_status
    @vehicles = Vehicle.where(status: "Parked")
    @vehicles.each do |vehicle|
       time = ((Time.now - vehicle.in_time)/60).ceil
      if time < 1440
          vehicle.status = Vehicle::STATUS[:issue]
          vehicle.save 
      end
    end
  end
end
