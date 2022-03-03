class AddDronesAndIdentifiers < ActiveRecord::Migration[6.0]
  def change
    create_table :drones do |t|
      t.string :name

      t.timestamps
    end

    create_table :drone_identifiers do |t|
      t.string :identifier

      t.timestamps
    end

    create_table :drone_identifier_types do |t|
      t.string :name
      t.string :slug

      t.timestamps
    end

    create_table :drone_identifier_sources do |t|
      t.string :name
      t.string :priority

      t.timestamps
    end

    add_reference :drone_identifiers, :drone
    add_reference :drone_identifiers, :drone_identifier_type
    add_reference :drone_identifiers, :drone_identifier_source
  end
end
