class DroneIdentifierType < ApplicationRecord
  SHOPIFY = 1
  STRIPE  = 2
  GITHUB  = 3

  has_many :drone_identifiers
end
