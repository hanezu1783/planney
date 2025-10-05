import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="event-form"
export default class extends Controller {
  // ターゲット要素を定義
  static targets = [
    "allDay",
    "timeFields",
    "dateFields",
    "startDatetime",
    "endDatetime",
    "startDate",
    "startHidden",
    "endHidden"
  ]

  // コントローラが接続されたとき（ページ表示時）に実行
  connect() {
    this.toggleFields()
  }

  // allDayチェックボックスや各入力欄が変更されたときに実行
  toggleFields() {
    if (this.allDayTarget.checked) {
      // 「終日」の場合
      this.timeFieldsTarget.style.display = 'none'
      this.dateFieldsTarget.style.display = 'block'
    } else {
      // 「終日」でない場合
      this.timeFieldsTarget.style.display = 'block'
      this.dateFieldsTarget.style.display = 'none'
    }
    this.updateHiddenFields()
  }

  // hiddenフィールドの値を更新
  updateHiddenFields() {
    this.startHiddenTarget.value = this.allDayTarget.checked ? this.startDateTarget.value : this.startDatetimeTarget.value
    this.endHiddenTarget.value = this.allDayTarget.checked ? this.startDateTarget.value : this.endDatetimeTarget.value
  }
}
