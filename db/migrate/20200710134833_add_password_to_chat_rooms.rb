class AddPasswordToChatRooms < ActiveRecord::Migration[5.2]
  def change
    add_column :chat_rooms, :private_room, :boolean, default: false
    add_column :chat_rooms, :password, :string
  end
end
