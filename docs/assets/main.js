(function (document) {
  document.addEventListener('DOMContentLoaded', function () {

    var switcher = document.querySelector('#color-switcher')
    var html = document.querySelector('html')
    var images = document.querySelectorAll('.image-switchable')

    switcher.addEventListener('click', function () {
      // Reload images:
      for (var i = 0; i < images.length; i++) {
        var srcNext = images[i].getAttribute('data-src')
        var srcCurrent = images[i].getAttribute('src')
        images[i].setAttribute('src', srcNext)
        images[i].setAttribute('data-src', srcCurrent)
      }

      // Toggle styles:
      html.classList.toggle('dark-mode')
      html.classList.toggle('white-mode')

      // Set button text:
      var textNext = switcher.getAttribute('data-text')
      var textCurrent = switcher.innerText

      switcher.innerText = textNext
      switcher.setAttribute('data-text', textCurrent)
    })
  })
})(document)
