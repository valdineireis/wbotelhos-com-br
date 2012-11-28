function initAntiBot(selector) {
  console.log(selector);
  $(selector).on('change', function() {
      var self  = $(this),
          form  = self.closest('form');

    if (self.is(':checked')) {
      form.attr('onsubmit', form.data('onsubmit'));
      self.prev('label').text('stupid! :/')
    } else {
      form.data('onsubmit', form.attr('onsubmit'));
      form.removeAttr('onsubmit');
      self.prev('label').text('human! <3')
    }
  });
};

function blurLabel() {
	var field = $(this);

	if (field.val() == '') {
		field.val(field.attr('title')).css('color', '#BBB');
	}
};

function focusLabel() {
	var field = $(this);

	if (field.val() == field.attr('title')) {
		field.val('').css('color', '#444');
	}
};

function l00s3r(selector) {
  $('label[for="' + selector + '"]').text('b0t? l00s3r!');
  return false;
};

$(function() {
  $('#social img').on('mouseover', function() {
    $(this).animate({ 'opacity': 1 }, { duration: 100, queue: false });
  }).on('mouseout', function() {
    $(this).animate({ 'opacity': .6 }, { duration: 100, queue: false });
  });
});
