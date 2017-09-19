$(document).on("turbolinks:load",function() {
  $(document).on('click', '.signup', function(e) {
    $('#login').addClass('hide');
    $('#register').removeClass('hide');
  });
  $(document).on('click', '.login', function(e) {
    $('#login').removeClass('hide');
    $('#register').addClass('hide');
  });
  $(document).on('click', '.update-user', function(e) {
    var password = $('.password-field').val();
    var passwordConfirmation = $('.password-confirmation-field').val();
    if (password != passwordConfirmation) {
      e.preventDefault();
      $('.password-group').addClass('red');
      $('.password-confirmation-group').addClass('red');
      alert("Passwords do not match");
    }
  });
});
