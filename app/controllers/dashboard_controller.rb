class DashboardController < ApplicationController
  before_action :authenticate_user!
  def index
    # --- グラフ用のデータを準備 ---
    # 今月の取引データを取得
    @date = Date.today
    monthly_transactions = current_user.transactions.where(date: @date.all_month)

    # 支出のみをカテゴリ別に集計
    monthly_expenses = monthly_transactions.where(transaction_type: :expense)
    @expense_by_category = monthly_expenses.group_by { |t| t.category&.name }
                                       .transform_values { |transactions| transactions.sum(&:price) }

    # --- 直近の取引3件を取得 ---
    @recent_transactions = monthly_transactions.order(date: :desc, created_at: :desc).limit(3)

    # --- スケジュール用のデータを準備 ---
    @events = current_user.events

    # --- 直近のスケジュールを取得 ---
    today = Date.today
    @todays_events = current_user.events.where(start_at: today.all_day).order(:start_at)
    @tomorrows_events = current_user.events.where(start_at: today.tomorrow.all_day).order(:start_at)
  end
end
