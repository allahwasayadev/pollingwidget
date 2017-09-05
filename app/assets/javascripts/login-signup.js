$(document).on('click', '.signup', function(e) {
  $('#login').addClass('hide');
  $('#register').removeClass('hide');
});
$(document).on('click', '.login', function(e) {
  $('#login').removeClass('hide');
  $('#register').addClass('hide');
});
