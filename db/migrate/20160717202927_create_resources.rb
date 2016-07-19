class CreateResources < ActiveRecord::Migration[5.0]
  def change
    create_table :resources do |t|
      t.string :delivery_id
      t.string :filename
      t.string :resolution
      t.string :supplier_name
      t.string :supplier_info
      t.string :delivery_date
      t.string :title
      t.string :episode
      t.integer :year
      t.string :som
      t.string :eom
      t.string :duration
      t.string :aspect_ratio
      t.string :material_type
      t.string :delivery_channel_group
      t.string :format
      t.string :audio_track_1
      t.string :audio_track_2

      t.timestamps
    end

    add_index(:resources, :delivery_id)
  end
end
