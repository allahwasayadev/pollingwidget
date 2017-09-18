var slideIndex = 1;
showDivs(slideIndex);

function plusDivs(n) {
  showDivs(slideIndex += n);
}

function showDivs(n) {
  var i;
  var x = document.getElementsByClassName("mySlides");
  if (n > x.length) {slideIndex = 1}
  if (n < 1) {slideIndex = x.length}
  for (i = 0; i < x.length; i++) {
     x[i].style.display = "none";
  }
  if (x.length) {
    x[slideIndex-1].style.display = "block";
  }
}
$(document).on("turbolinks:load",function() {
  return setTimeout((function() {
    return $('.alert').slideUp();
  }), 3000);
});
