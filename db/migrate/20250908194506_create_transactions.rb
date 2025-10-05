class CreateTransactions < ActiveRecord::Migration[7.1]
  def change
    create_table :transactions do |t|
      t.references :user, null: false, foreign_key: true
      t.string :title, null: false
      t.integer :price, null: false
      t.date :date, null: false
      t.integer :transaction_type
      t.integer :category_id, null: false
      t.integer :pay_type
      t.text :memo
      t.timestamps
    end
  end
end
