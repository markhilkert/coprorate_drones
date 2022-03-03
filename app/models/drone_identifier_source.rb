class DroneIdentifierSource < ApplicationRecord
  UNKNOWN  = 1
  BOOTCAMP = 2
  NEW_GRAD = 3

  has_many :drone_identifiers
end
