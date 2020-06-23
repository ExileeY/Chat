class ChatChannel < ApplicationCable::Channel
  def subscribe(params)
  	stop_all_streams
    stream_from "chat:#{params['chat_room_id'].to_i}:messages"
  end

  def unsubscribe
  	stop_all_streams
  end
end
