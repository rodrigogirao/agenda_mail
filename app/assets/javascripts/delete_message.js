$(document).on('turbolinks:load',function (){

  if ($('#unread_messages').length){
    $('#unread_messages').text('Mensagens (' + $('.content').first().data('unread') + ')')
  }

  $('.single_archive').on('click',function(){
    var message_title = $(this).first().parent().parent().find('.message_content').text();
    var is_unread = $(this).parent().parent().hasClass('unread');
    $.ajax({
      url: '/archive',
      method: 'PATCH',
      data: {title: message_title},
      success: function(data){
        $("td:contains("+ message_title +")").parent().remove();
        if (is_unread){
          $('.content').first().data('unread',$('.content').first().data('unread') - 1)
          $('#unread_messages').text('Mensagens (' + $('.content').first().data('unread') + ')')
        }
      }
    });
  })
});
