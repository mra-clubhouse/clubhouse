import ApplicationController from './application_controller.js'
let debounce = require('lodash/debounce')

export default class extends ApplicationController {
  connect() {
    super.connect()
  }

  initialize() {
    this.livesearch = debounce(this.submit, 200)
  }

  submit(event) {
    event.preventDefault()

    this.stimulate()
  }

  clear(event) {
    document.getElementById("post_search").reset()

    this.stimulate('Search#clear')
  }
}
