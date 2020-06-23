  App.chat = App.cable.subscriptions.create "ChatChannel",
    collection: -> $('#messages')

    connected: ->
      setTimeout =>
        @followCurrentChatRoom()
      , 1000

    disconnected: ->

    followCurrentChatRoom: ->
      chatRoomId = @collection().data('chat_room-id')
      if chatRoomId
        @perform 'subscribe', chat_room_id: chatRoomId
      else
        @perform 'unsubscribe'

    received: (data) ->
      messages = $('#room-messages')
      @collection().append(data['message'])
      messages.scrollTop(messages[0].scrollHeight)