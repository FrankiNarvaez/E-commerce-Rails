import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["items"]

  toggle() {
    this.itemsTarget.classList.toggle('-translate-y-48');
    this.itemsTarget.classList.toggle('h-0');
  }
}
