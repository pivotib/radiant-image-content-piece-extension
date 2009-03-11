document.observe('dom:loaded', function() {
when('content_image_name', function(title) {
	
  var slug = $('content_image_slug'),
      oldTitle = title.value;

  if (!slug) return;

  new Form.Element.Observer(title, 0.15, function() {
    if (oldTitle.toSlug() == slug.value) slug.value = title.value.toSlug();
    oldTitle = title.value;
  });
});
});