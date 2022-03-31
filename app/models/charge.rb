class Charge < ApplicationRecord
    has_many :vehicles
    TYPE = {car: 'car', bike: 'bike'}
end