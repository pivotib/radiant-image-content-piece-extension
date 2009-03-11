class CreateContentImages < ActiveRecord::Migration
  def self.up
    create_table :content_images do |t|
      t.integer :id
      t.string :name
      t.string :slug
      t.string :alt
      t.date :created_at
      t.date :updated_at
      t.integer :created_by_id
      t.integer :updated_by_id

      t.timestamps
    end
  end

  def self.down
    drop_table :content_images
  end
end
