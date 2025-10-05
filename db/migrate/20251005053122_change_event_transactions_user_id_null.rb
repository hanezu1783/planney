class ChangeEventTransactionsUserIdNull < ActiveRecord::Migration[7.1]
  def change
    change_column_null :event_transactions, :user_id, true
  end
end
