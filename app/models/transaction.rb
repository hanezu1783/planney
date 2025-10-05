class Transaction < ApplicationRecord
  # ActiveHashとのアソシエーション
  extend ActiveHash::Associations::ActiveRecordExtensions
  belongs_to :user
  belongs_to :category
  has_many :event_transactions, foreign_key: 'transaction_id', dependent: :destroy
  has_many :events, through: :event_transactions, source: :event

  enum transaction_type: { income: 0, expense: 1 }, _prefix: true
  enum pay_type: { cash: 0, credit_card: 1, e_money: 2, bank_transfer: 3 }, _prefix: true

  # 共通のバリデーション
  validates :transaction_type, presence: true
  validates :title, presence: true
  validates :price, presence: true, numericality: { only_integer: true, greater_than: 0 }
  validates :date, presence: true

  # 支出(expense)の場合のみバリデーションを適用
  with_options if: :transaction_type_expense? do
    validates :pay_type, presence: true
    validates :category_id, numericality: { other_than: 1, message: "を選択してください" }
  end

  # Transaction保存後に中間テーブルのuser_idを更新する
  after_save :update_event_transactions_user_id, if: -> { user_id.present? }

  # enumの値を日本語に変換するメソッド
  def transaction_type_text
    I18n.t("activerecord.attributes.transaction.transaction_types.#{transaction_type}")
  end

  def pay_type_text
    I18n.t("activerecord.attributes.transaction.pay_types.#{pay_type}") if pay_type.present?
  end

  private

  def update_event_transactions_user_id
    event_transactions.where(user_id: nil).update_all(user_id: user_id)
  end
end
