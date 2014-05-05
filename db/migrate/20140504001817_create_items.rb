class CreateItems < ActiveRecord::Migration
  def change
    create_table :items do |t|
      t.string :name
      t.text :description

      t.integer :price, default: 0, index: true

      t.integer :watch_count, default: 0, index: true
      t.integer :like_count, default: 0, index: true
      t.integer :dislike_count, default: 0, index: true


      t.references :location, index: true
      t.references :user, index: true

      t.timestamps
    end

  end
end
