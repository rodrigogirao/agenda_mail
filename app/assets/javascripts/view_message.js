$(document).on('turbolinks:load',function (){
  $('.view_message').on('click', function(e){
    $(this).parent().parent().removeClass('unread')
  });

  $(".clickable").click(function() {
    window.location = $(this).find('.view_message').attr('href');
  });

  $(".clickable_user").click(function() {
    window.location = $(this).data('href');
  });
});

