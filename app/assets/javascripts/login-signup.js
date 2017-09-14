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
  $(document).on('click', '.collect-ids', function(e) {
    var ids = [];
   $('.add-to-poll:checkbox:checked').each(function( index ) {
      ids.push($( this ).val());
    });
    var a = $(this).parent('a')[0]
    var href = a.href.split('?')[0];
    var category_id = $('.get-category').val();
    var type = $('.get-type').val();
    if(href) {
        a.href = href + "?question_ids="+ids+"&category_id="+category_id+"&poll_type="+type;
        e.preventDefault();
    }
  });
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
  $( ".get-category, .get-type" ).change(function() {
    var category_id = $( ".get-category" ).val();
    var type = $( ".get-type" ).val();
    $.ajax({
      method: 'GET',
      url: "/polls/update_questions",
      dataType : 'script',
      data: { poll: { category_id: category_id,question_type: type } },
      success: function (response) {
        if ($('#questions-table').hasClass('hide')) {
          $('#questions-table').removeClass('hide');
        }
      }
    }).fail(function () {
      alert("the call failed");
    })
  });
  $( ".get-created-category, .get-created-type" ).change(function() {
    var category_id = $( ".get-created-category" ).val();
    var type = $( ".get-created-type" ).val();
    $.ajax({
      method: 'GET',
      url: "/polls",
      dataType : 'script',
      data: { poll: { category_id: category_id,poll_type: type } },
      success: function (response) {
        // if ($('#questions-table').hasClass('hide')) {
        //   $('#questions-table').removeClass('hide');
        // }
      }
    }).fail(function () {
      alert("the call failed");
    })
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


