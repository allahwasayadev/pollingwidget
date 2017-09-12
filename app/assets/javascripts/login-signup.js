$(document).on("turbolinks:load",function() {
  return setTimeout((function() {
    return $('.alert').slideUp();
  }), 3000);
});
$(document).on("turbolinks:load",function() {
  $(document).on('click', '.signup', function(e) {
    $('#login').addClass('hide');
    $('#register').removeClass('hide');
  });
  $(document).on('click', '.login', function(e) {
    $('#login').removeClass('hide');
    $('#register').addClass('hide');
  });
  $(document).on('click', '#multiple-choice', function() {
    $(".multiple").show();
    $(".truefalse").hide();
  });
  $(document).on('click', '#true-false', function() {
    $(".truefalse").show();
    $(".multiple").hide();
  });
  $(".question-fields :input").attr("disabled", true);
  $( ".question-select" ).attr("disabled", true);

  $( ".new-question" ).click(function() {
    $( ".question-select" ).attr("disabled", false);
  });
  $( ".question-select" ).change(function() {
    $(".question-fields :input").attr("disabled", false);
  });
      $('.preview-block').preview({
    form: '#form'
});
});
function readURL(input) {
        if (input.files && input.files[0]) {
          var reader = new FileReader();

          reader.onload = function (e) {
            $('#img_prev')
              .attr('src', e.target.result)
              .width(130)
              .height(105);
          };

          reader.readAsDataURL(input.files[0]);
        }
        $('#img_prev').removeClass('hide');
      }

