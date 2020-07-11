class CreateUserRoomPasswords < ActiveRecord::Migration[5.2]
  def change
    create_table :user_room_passwords do |t|
      t.integer :user_id
      t.integer :chat_room_id
      t.string :password

      t.timestamps
    end
  end
end
