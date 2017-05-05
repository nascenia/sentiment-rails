App.messages = App.cable.subscriptions.create 'MessagesChannel',
    received: (data) ->
      conversation = $("[data-conversation='" + data.conversation_id + "']");
      conversation.append(data.message);
      conversation.siblings("#message_content").focus();
      conversation.animate({ scrollTop: conversation[0].scrollHeight}, "slow");
    speak: (options) ->
      @perform 'speak', options

$(document).on 'keydown','textarea#message_content', (event) ->
    if event.keyCode is 13
      msg = event.target.value;
      con = $(this).siblings("div.messages-list:first").find(".conversation-thread");
      conversationId = con.data().conversation;
      App.messages.speak({message: msg, conversation_id: conversationId});
      $(this).val(" ")