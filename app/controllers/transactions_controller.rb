class TransactionsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_transaction, only: [:show, :edit, :update, :destroy]

  def index
    # パラメータから月を取得、なければ今月を基準にする
    @date = params[:month] ? Date.parse("#{params[:month]}-01") : Date.today

    # 指定された月の取引データを取得
    monthly_transactions = current_user.transactions.where(date: @date.all_month)
    @transactions = monthly_transactions.order(date: :desc)

    # 円グラフ用のデータを作成 (支出のみをカテゴリ別に集計)
    # ActiveHashのため、joinsやgroupは使わずにRubyで処理する
    monthly_expenses = monthly_transactions.where(transaction_type: :expense)
    @expense_by_category = monthly_expenses.group_by { |t| t.category&.name }
                                   .transform_values { |transactions| transactions.sum(&:price) }

    # イベントごとの支出一覧データを取得
    @events_with_expenses = current_user.events
                                        .where(start_at: @date.all_month)
                                        .includes(:transactions)
                                        .order(start_at: :asc)
  end

  def new
    @transaction = Transaction.new
    @categories = Category.all # カテゴリは新規作成時にも必要
  end

  def create
    @transaction = current_user.transactions.new(transaction_params)
    if @transaction.save
      redirect_to transactions_path, notice: '家計簿に記録しました。'
    else
      # バリデーションエラーでnew画面を再表示する際に、@categoriesを再設定します
      @categories = Category.all
      render :new, status: :unprocessable_entity
    end
  end

  def show
    # before_action :set_transaction で @transaction が設定されます
  end

  def edit
    set_edit_form_collections
  end

  def update
    if @transaction.update(transaction_params)
      redirect_to transactions_path, notice: '記録を更新しました。'
    else
      set_edit_form_collections
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @transaction.destroy
    redirect_to transactions_path, notice: '記録を削除しました。'
  end


  private

  def set_transaction
    @transaction = current_user.transactions.find(params[:id])
  end

  def transaction_params
    params.require(:transaction).permit(
      :title, :transaction_type,
      :date,
      :price,
      :transaction_type,
      :category_id,
      :pay_type,
      :memo,
      event_ids: []
    ).tap do |whitelisted|
      # 空文字の event_id を除外
      whitelisted[:event_ids]&.reject!(&:blank?)
    end
  end

  def set_edit_form_collections
    @categories = Category.all
    @events = current_user.events.order(start_at: :desc)
  end
end
