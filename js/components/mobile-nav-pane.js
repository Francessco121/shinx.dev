$(document).ready(function () {
  function toggleHeaderNav() {
    $('#mobile-nav-pane').toggleClass('active');
    $('#mobile-nav-pane-cancel').toggleClass('active');
  }

  $('[data-toggle="mobile-nav-pane"]').click(toggleHeaderNav);
  $('#mobile-nav-pane-cancel').click(toggleHeaderNav);
});