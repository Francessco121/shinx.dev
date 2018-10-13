var fullscreenImages = {
  showImage: function(url) {
    $('.fullscreen-image').attr('src', url);
    $('.fullscreen-image-wrapper').show();
  },
  
  hideImage: function() {
    $('.fullscreen-image-wrapper').hide();
  }
}

$(document).ready(function () {
  $('.fullscreen-image-wrapper').on('click', function() {
    fullscreenImages.hideImage();
  });
  $('.fullscreen-image').on('click', function(evt) {
    evt.stopPropagation();
  });
});