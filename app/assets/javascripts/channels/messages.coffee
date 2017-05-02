App.messages = App.cable.subscriptions.create 'MessagesChannel',
    received: (data) ->
        $("[data-conversation='" + data.conversation_id + "']").append(data.message);
        $("[data-conversation='" + data.conversation_id + "']").siblings("#message_content").focus();
    speak: (options) ->
      @perform 'speak', options

$(document).on 'keydown','textarea#message_content', (event) ->
    if event.keyCode is 13
      msg = event.target.value;
      conversationId = $(this).siblings($("[data-conversation]")).data().conversation;
      App.messages.speak({message: msg, conversation_id: conversationId});
      $(this).val(" ")