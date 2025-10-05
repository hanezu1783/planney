class CreateEventTransactions < ActiveRecord::Migration[7.1]
  def change
    create_table :event_transactions do |t|
      t.references :user, null: false, foreign_key: true
      t.references :event, null: false, foreign_key: true
      t.references :transaction, null: false, foreign_key: true
      t.timestamps
    end
  end
end
