class TransactionsController < ApplicationController
  before_action :authenticate_user!

  def index
    # 今後の実装のために空けておく
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

  private

  def transaction_params
    params.require(:transaction).permit(
      :transaction_type, :date, :price, :memo, :category_id, :pay_type
    ).merge(user_id: current_user.id)
  end
end
