import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["items", "open_menu", "close_menu"]

  toggle () {
    this.itemsTarget.classList.toggle('-translate-y-48');
    this.itemsTarget.classList.toggle('h-0');
    this.open_menuTarget.classList.toggle('hidden');
    this.close_menuTarget.classList.toggle('hidden');
  }
}