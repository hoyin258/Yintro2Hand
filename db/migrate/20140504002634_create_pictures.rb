class CreatePictures < ActiveRecord::Migration
  def change
    create_table :pictures do |t|

      t.attachment :file
      t.references :item, index:true
      t.timestamps
    end

  end
end
