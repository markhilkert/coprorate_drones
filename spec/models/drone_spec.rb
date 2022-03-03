require 'rails_helper'

RSpec.describe Drone, type: :model do
  describe '.find_by_identifier' do
    it 'should return nil when nothing matches' do
      subject = Drone.find_by_identifier('abc', DroneIdentifierType::SHOPIFY)
      expect(subject).to eq nil
    end

    it 'should return a single record' do
      existing = build(:drone)
      existing.drone_identifiers.build(
        identifier: 'abcdef',
        drone_identifier_type: DroneIdentifierType.find(DroneIdentifierType::SHOPIFY),
        drone_identifier_source: DroneIdentifierSource.find(DroneIdentifierSource::UNKNOWN)
      )
      existing.save!

      subject = Drone.find_by_identifier('abcdef', DroneIdentifierType::SHOPIFY)
      expect(subject.new_record?).to eq false
      expect(subject).to eq existing
    end

    it 'should use the higher-priority source when multiple sources use the same identifier' do
      common_identifier = 'abcdef'
      common_identifier_type = DroneIdentifierType::GITHUB

      # setup
      DroneIdentifierSource.find(DroneIdentifierSource::BOOTCAMP).update(priority: 50)
      DroneIdentifierSource.find(DroneIdentifierSource::NEW_GRAD).update(priority: 51)

      according_to_amara = build(:drone)
      according_to_amara.drone_identifiers.build(
        identifier: common_identifier,
        drone_identifier_type_id: common_identifier_type,
        drone_identifier_source_id: DroneIdentifierSource::BOOTCAMP
      )
      according_to_amara.save!

      according_to_dronemetrics = build(:drone)
      according_to_dronemetrics.drone_identifiers.build(
        identifier: common_identifier,
        drone_identifier_type_id: common_identifier_type,
        drone_identifier_source_id: DroneIdentifierSource::NEW_GRAD
      )
      according_to_dronemetrics.save!

      # test
      found = Drone.find_by_identifier(common_identifier, common_identifier_type)

      # assert
      expect(found).to eq according_to_amara

      # update. now dronemetrics is higher priority
      DroneIdentifierSource.find(DroneIdentifierSource::BOOTCAMP).update(priority: 61)
      DroneIdentifierSource.find(DroneIdentifierSource::NEW_GRAD).update(priority: 60)

      # test
      found = Drone.find_by_identifier(common_identifier, common_identifier_type)

      # assert
      expect(found).to eq according_to_dronemetrics
    end
  end
end
