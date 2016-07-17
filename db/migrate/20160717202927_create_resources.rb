class CreateResources < ActiveRecord::Migration[5.0]
  def change
    create_table :resources do |t|
      t.string :delivery_id
      t.string :title
      t.string :episode
      t.integer :year
      t.string :duration
      t.string :aspect_ratio

      t.timestamps
    end

    add_index(:resources, :delivery_id)
  end
end
