class Vehicle < ApplicationRecord
    belongs_to :user
    belongs_to :charge
    validates :status, presence: true
    STATUS = {Parked: 'Parked', Left: 'left'}.freeze
end