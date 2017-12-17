$(document).on('turbolinks:load',function (){
  $('.view_message').on('click', function(e){
    $(this).parent().parent().removeClass('unread')
  });
});

