import ApplicationController from './application_controller.js'

export default class extends ApplicationController {
  connect() {
    super.connect()

    this.element.addEventListener("keyup", (event)=> {
      // Sends the message if the enter key is hit while the textarea
      // is focussed and the shift key is not currently pressed.
      if (event.code === "Enter" && !event.shiftKey) {
        event.preventDefault()
        this.stimulate('MessageReflex#send')
      }
    })
  }
}
