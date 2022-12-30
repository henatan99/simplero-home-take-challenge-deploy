import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="groupmodal"
export default class extends Controller {
  static targets = ["modal"]
  connect() {
    this.modalTarget.hidden = true
  }

  showhide() {
    this.modalTarget.hidden = !this.modalTarget.hidden
  }
}
