class CreateUserMutes < ActiveRecord::Migration[5.2]
  def change
    create_table :user_mutes do |t|
      t.integer :user_id
      t.integer :chat_room_id
      t.boolean :muted
      t.datetime :time

      t.timestamps
    end
  end
end
