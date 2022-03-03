class Drone < ApplicationRecord
  has_many(:drone_identifiers,
    ->() { joins(:drone_identifier_source).order('drone_identifier_sources.priority') },
    dependent: :destroy,
    inverse_of: :drone
  )

  def self.find_by_identifier(identifier, drone_identifier_type_id)
    find_by_identifier! identifier, drone_identifier_type_id
  rescue ActiveRecord::RecordNotFound
    nil
  end

  def self.find_by_identifier!(identifier, drone_identifier_type_id)
    joins(drone_identifiers: :drone_identifier_source)
      .where(
        drone_identifiers: {
          identifier: identifier,
          drone_identifier_type_id: drone_identifier_type_id
        }
      )
      .order('drone_identifier_sources.priority')
      .first!
  end
end
