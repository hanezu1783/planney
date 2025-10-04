class TransactionsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_transaction, only: [:show] # :edit, :update, :destroy も今後追加

  def index
    # N+1問題を避けるためにincludes(:category)を追加
    @transactions = current_user.transactions.order(date: :desc)

    # 円グラフ用のデータを作成 (支出のみをカテゴリ別に集計)
    # ActiveHashのため、joinsやgroupは使わずにRubyで処理する
    expenses = current_user.transactions.where(transaction_type: :expense)
    @expense_by_category = expenses.group_by { |t| t.category&.name }
                                   .transform_values { |transactions| transactions.sum(&:price) }
  end

  def new
    @transaction = Transaction.new
    @categories = Category.all
  end

  def create
    @transaction = Transaction.new(transaction_params)
    if @transaction.save
      redirect_to root_path, notice: '家計簿に記録しました。'
    else
      # バリデーションエラーでnew画面を再表示する際に、@categoriesを再設定します
      @categories = Category.all
      render :new, status: :unprocessable_entity
    end
  end

  def show
    # before_action :set_transaction で @transaction が設定されます
  end

  private

  def set_transaction
    @transaction = current_user.transactions.find(params[:id])
  end

  def transaction_params
    params.require(:transaction).permit(
      :transaction_type, :title, :date, :price, :memo, :category_id, :pay_type
    ).merge(user_id: current_user.id)
  end
end
