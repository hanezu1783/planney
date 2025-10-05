class Event < ApplicationRecord
  belongs_to :user
  has_many :event_transactions, dependent: :destroy
  has_many :transactions, through: :event_transactions, source: :expense_record # 修正: sourceをexpense_recordに

  validates :event_title, presence: true
  validates :start_at, presence: true
  validates :end_at, presence: true, unless: :all_day?
end