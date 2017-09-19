$(document).on("turbolinks:load",function() {
  $(document).on('change', '.get-category, .get-type', function(e) {
    e.stopImmediatePropagation();
    var category_id = $( ".get-category" ).val();
    var type = $( ".get-type" ).val();
    if (category_id=="" || type=="" ) {
      $("#questions-table").hide();
      $('#preview-poll').addClass('hide');
      $('.mySlides').remove();
    }
    else {
      $("#questions-table").show();
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
    }
  });
  $(document).on('change', '.get-created-category, .get-created-type', function(e) {
    var category_id = $( ".get-created-category" ).val();
    var type = $( ".get-created-type" ).val();
    $.ajax({
      method: 'GET',
      url: "/polls",
      dataType : 'script',
      data: { poll: { category_id: category_id,poll_type: type } },
      success: function (response) {
      }
    }).fail(function () {
      alert("the call failed");
    })
  });


  var question_ids = [];
  var divs = 0;
  $(document).on('change', '.add-to-poll', function(e) {
    e.stopImmediatePropagation();
    if (this.checked) {
        // the checkbox is now checked
      if (question_ids.length == 10 ) {
        $(this).removeAttr('checked');
        alert("cannot check more than 10 questions")
      }
      else {
        var x=$(this).data("value");
        question_ids.push(x.id)
        divs += 1;
        if (x.image.url == null) {
          x.image.thumb.url = '/assets/avatar-68353a8dcd39284947f1c151b12688110ef4b0ae6c2dabcf09ee93694b748f81.png';
        }
        if (x.question_type == "Multi") {
          var html = "<div class='mySlides' id=slide-"+x.id+" style='display: block;'><div class='row'>"+
                "<div class='col-sm-4'><div class='profile-image' type='file'>"+
                "<img src="+x.image.thumb.url+">"+
                "</div></div><div class='col-sm-8'><div class='field form-group'><p>"
                +x.question+"</p></div><div class='field form-group'>"+
                "<ul class='question-list edit-question'>"+
                "<li><input class='form-control' disabled='' id='question_options' name='question[options][1]' type='text' value="+x.options['1']+"></li>"+
                "<li><input class='form-control' disabled='' id='question_options' name='question[options][2]' type='text' value="+x.options['2']+"></li>"+
                "<li><input class='form-control' disabled='' id='question_options' name='question[options][3]' type='text' value="+x.options['3']+"></li>"+
                "<li><input class='form-control' disabled='' id='question_options' name='question[options][4]' type='text' value="+x.options['4']+"></li>"+
                "</ul></div></div></div></div>";
        }
        else {
          var html = "<div class='mySlides' id=slide-"+x.id+" style='display: block;'><div class='row'>"+
                  "<div class='col-sm-4'><div class='profile-image' type='file'>"+
                  "<img src="+x.image.thumb.url+">"+
                  "</div></div><div class='col-sm-8'><div class='field form-group'><p>"
                  +x.question+"</p></div><div class='field form-group'><ul class='radio-list'>"+
                  "<li><label class='radio-inline'><input disabled='' name='question[correct_option]' type='radio' value='true'>TRUE</label></li>"+
                  "<li><label class='radio-inline'><input disabled='' name='question[correct_option]' type='radio' value='false'>FALSE</label></li>"+
                  "</ul></div></div></div></div>";

        }
        $('#set-question-ids').val(question_ids);

        $('#carousel-display').append( html );
        showDivs(divs);
        if($('#preview-poll').hasClass('hide')) {
          $('#preview-poll').removeClass('hide');
        }
      }
    } else {
        // the checkbox is now no longer checked
        $('#slide-'+$(this).val()).remove();
        plusDivs(1)
        question_ids.splice( question_ids.indexOf($(this).val()), 1 );
    }
  });
  $(document).on('click', '.create-poll', function(e) {
   var name = $('.poll-name').val();
   if (name == "") {
    e.preventDefault();
    $('.poll-name').attr("placeholder", "Name can't be blank");
    $('.poll-name').focus();
   }
  });
  $(document).on('click', '#slide-left , #slide-right', function(e) {
    var sections = $('.mySlides');
    var index = sections.index($(".mySlides:visible"))+1;
   $('#question-number').html((index)+'/'+sections.length)
   if (index == sections.length) {
    if (index == 1) {
      $('#slide-left').attr("disabled", true);
    }
    else {
      $('#slide-left').attr("disabled", false);
    }
    $('#slide-right').attr("disabled", true);
   }
   else if (index == 1) {
    if (index == sections.length) {
      $('#slide-right').attr("disabled", true);
    }
    else {
      $('#slide-right').attr("disabled", false);
    }
    $('#slide-left').attr("disabled", true);
   }
   else{
    $('#slide-right').attr("disabled", false);
    $('#slide-left').attr("disabled", false);
   }
  });
});
