$(function() {
  
  var clip = new ZeroClipboard($("#copy-button"))
  
  $('#new_link').submit(function() {
    $.post($('#new_link').attr('action'), $('#new_link').serialize(), function(data){
      $('.shortened_link input').attr('value', data.given_url);
      $('.shortened_link').removeClass('hidden');
      $('.whatever').hide();
    }, "json");
    return false;
  })
});
