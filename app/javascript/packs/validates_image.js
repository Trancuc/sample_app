const BYTE = 1024;
const IMAGE_SIZE = 5;
$('#micropost_image').bind('change', function () {
  var size_in_megabytes = this.files[0].size / BYTE / BYTE;
  if (size_in_megabytes > IMAGE_SIZE) {
    alert(I18n.t('shared.micropost_form.alert'));
    $(this).val(null);
  }
});
