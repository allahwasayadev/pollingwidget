$(document).on('click', '.signup', function(e) {
  $('#login').addClass('hide');
  $('#register').removeClass('hide');
});
$(document).on('click', '.login', function(e) {
  $('#login').removeClass('hide');
  $('#register').addClass('hide');
});
$(document).on("turbolinks:load",function() {
  return setTimeout((function() {
    return $('.alert').slideUp();
  }), 3000);
});
