// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or vendor/assets/javascripts of plugins, if any, can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// the compiled file.
//
// WARNING: THE FIRST BLANK LINE MARKS THE END OF WHAT'S TO BE PROCESSED, ANY BLANK LINE SHOULD
// GO AFTER THE REQUIRES BELOW.
//
//= require jquery
//= require jquery_ujs
//= require bootstrap
//= require_tree .
function check(){
  content = document.getElementById('micropost_content')
  length_object = document.getElementById('rest-char')
  real_length = 140 - content.value.length;
  record_length = length_object.innerHTML;
  if(real_length != record_length){
    document.getElementById('rest-char').innerHTML = real_length;
  }
  setTimeout("check()",100);
}
