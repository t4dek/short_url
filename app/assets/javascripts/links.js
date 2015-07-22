$(function() {
  $(document).ready(function() {
    $('.shortened_link').hide();
  });
  
  $('#new_link').submit(function() {
    $.post($('#new_link').attr('action'), $('#new_link').serialize(), function(data){
      $('.shortened_link a').attr('href', data.given_url);
      $('.shortened_link').show();
    }, "json");
    return false;
  })
});
