class CreateEventTransactions < ActiveRecord::Migration[7.1]
  def change
    create_table :event_transactions do |t|

      t.timestamps
    end
  end
end
