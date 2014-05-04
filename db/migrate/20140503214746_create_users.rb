class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :name
      t.string :facebook_name
      t.string :password_digest
      t.string :facebook_id, null: false, default: ""
      t.string :token
      t.string :email

      t.timestamps
    end

    add_index :users, :facebook_id, unique: true

  end
end