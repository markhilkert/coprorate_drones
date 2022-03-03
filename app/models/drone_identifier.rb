class DroneIdentifier < ApplicationRecord
  belongs_to :drone_identifier_type
  belongs_to :drone_identifier_source
  belongs_to :drone, inverse_of: :drone_identifiers
end
