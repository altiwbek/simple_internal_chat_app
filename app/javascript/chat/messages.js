
$(document).on('turbolinks:load', function() {
  var msg_history = document.getElementById('js-msg-history');
  if(msg_history != null){ msg_history.scrollTop = msg_history.scrollHeight; }
});