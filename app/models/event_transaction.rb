class EventTransaction < ApplicationRecord
  belongs_to :user, optional: true
  belongs_to :event
  belongs_to :expense_record, class_name: 'Transaction', foreign_key: 'transaction_id'
end
