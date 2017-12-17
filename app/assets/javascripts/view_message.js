$(document).on('turbolinks:load',function (){
  $('.view_message').on('click', function(e){
    $(this).parent().parent().removeClass('unread')
  });
});


$(document).on('DOMNodeInserted', function(event){
  if($(event).hasClass("alert")){
    console.log('entrou')
    $.notify({
      // options
      message: 'Hello World'
    },{
      // settings
      type: 'danger'
    });
  }
});
