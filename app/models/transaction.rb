class Transaction < ApplicationRecord
  # ActiveHashとのアソシエーション
  extend ActiveHash::Associations::ActiveRecordExtensions
  belongs_to :user
  belongs_to :category

  enum transaction_type: { income: 0, expense: 1 }, _prefix: true
  enum pay_type: { cash: 0, credit_card: 1, e_money: 2, bank_transfer: 3 }, _prefix: true

  # 共通のバリデーション
  validates :transaction_type, presence: true
  validates :title, presence: true
  validates :price, presence: true, numericality: { only_integer: true, greater_than: 0 }
  validates :date, presence: true

  # 支出(expense)の場合のみバリデーションを適用
  with_options if: :transaction_type_expense? do
    validates :pay_type, :category_id, presence: true
  end
end
