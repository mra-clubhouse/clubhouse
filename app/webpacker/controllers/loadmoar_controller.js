import ApplicationController from './application_controller.js'

export default class extends ApplicationController {
  connect() {
    super.connect()

    let options = {
      root: document.querySelector(".messages-content"),
      rootMargin: "200px 0px 0px 0px",
      threshold: 0
    }

    let interector = document.getElementById("intersector")

    let intersectionCallback = (entries, observer) => {
      entries.forEach(entry => {
        if (!entry.isIntersecting) return

        this.load()
      })
    }

    let observer = new IntersectionObserver(intersectionCallback, options)

    observer.observe(interector)
  }

  load() {
    let last_message = document.querySelector("#messages .card:last-child")
    let timestamp = last_message.getAttribute("data-timestamp")
    let last_id = last_message.getAttribute("id")

    this.stimulate("Message#load_more", { last_id: last_id, timestamp: timestamp, limit: 10 })
  }
}
