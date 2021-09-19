import { Controller } from "stimulus"

export default class extends Controller {
  connect() {
    let message_area = document.querySelector(".messages-content")
    message_area.scrollTop = message_area.scrollHeight
  }
}
