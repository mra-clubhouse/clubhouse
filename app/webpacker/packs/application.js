// This file is automatically compiled by Webpack, along with any other files
// present in this directory. You're encouraged to place your actual application logic in
// a relevant structure within app/javascript and only use these pack files to reference
// that code so it'll be compiled.

import "channels"
import "controllers"
import CableReady from "cable_ready"
import mrujs from "mrujs"
import { CableCar } from "mrujs/plugins"
import * as Turbo from "@hotwired/turbo"

window.Turbo = Turbo

mrujs.start({ plugins: [new CableCar(CableReady)] })

import "@fortawesome/fontawesome-free/css/all.css";

window.addEventListener("ajax:complete", () => {
  document.querySelector("input[type=submit]:disabled")?.removeAttribute("disabled")
})

const images = require.context('../images', true)
const imagePath = (name) => images(name, true)
