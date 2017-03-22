$(document).ready(function () {
    function toggleHeaderNav() {
        $('.header-nav-mobile-pane').toggleClass('active');
        $('.header-nav-mobile-pane-cancel').toggleClass('active');
    }

    $('[data-toggle="header-nav"]').click(toggleHeaderNav);
    $('.header-nav-mobile-pane-cancel').click(toggleHeaderNav);
});