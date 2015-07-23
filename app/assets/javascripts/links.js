$(function() {
  
  var clip = new ZeroClipboard($("#copy-button"))
  
  $('#new_link').submit(function() {
    $.post($('#new_link').attr('action'), $('#new_link').serialize(), function(data){
      $('.shortened_link input').attr('value', data.short_url);
      $('.shortened_link').removeClass('hidden');
      $('.whatever').hide();
    }, "json").fail(function(data) {
      $('#alerts').removeClass('hidden');
      $.each(data.responseJSON.given_url, function(i, object){
        $('#alerts ul').append('<li>' + object + '</li>')
      })
    });
    return false;
  })
});
