import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="flash"
export default class extends Controller {
  connect() {
    const timeout = setTimeout(() => {
      this.dismiss()
    }, 4000)
  }
  dismiss() {
    this.element.classList.add("opacity-0", "transition-opacity", "duration-500")

    setTimeout(() => {
      this.element.remove()
    }, 500)
  }
}
