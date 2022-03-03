FactoryBot.define do
  factory :drone_identifier do
    sequence(:identifier, 'a')
  end

  trait :with_drone do
    drone { build(:drone) }
  end
  trait :with_video_identifier_type do
    video_identifier_type { DroneIdentifierType.find(DroneIdentifierType::SHOPIFY) }
  end
  trait :with_video_identifier_source do
    video_identifier_source { DroneIdentifierSource.find(DroneIdentifierSource::UNKNOWN) }
  end

  trait :all_assoc do
    with_drone
    with_video_identifier_type
    with_video_identifier_source
  end
end
