
$(document).on('turbolinks:load', function() {
  console.log('turbolinks')
  $('#new_message').on('submit', function(e, data, status, xhr){
    console.log(e)
    console.log(data)
    console.log(status)
    console.log(xhr)
  })
})