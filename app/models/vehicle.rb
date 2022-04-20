class Vehicle < ApplicationRecord
    belongs_to :user
    belongs_to :charge
    validates :status, presence: true
    STATUS = {parked: 'Parked', left: 'Left'}.freeze

    def calculate_fees
        charge_fees = self.charge
        total_hours = (self.total_time / 60.0).ceil
        if total_hours <= charge_fees.min_hours
            charge_fees.min_charge
          else
            extra_hour = total_hours - charge_fees.min_hours
            charge_fees.min_charge + (extra_hour.round *  charge_fees.extra_hour_charges)
          end
    end

end
