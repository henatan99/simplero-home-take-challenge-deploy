import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="posts"
export default class extends Controller {
  static targets = ["editPost", "updatePost", "postId", "postIdFromData"]
  connect() {
    this.id = "Empty"
    this.idFromData = "Empty"
  }

  edit(event) {
    event.preventDefault()
    this.id = event.target.id
    this.idFromData = event.target.dataset.id
    this.postIdTarget.textContent = this.id
    this.postIdFromDataTarget.textContent = this.idFromData
  }
}
