class CreateEvents < ActiveRecord::Migration[7.1]
  def change
    create_table :events do |t|
      t.references :user, null: false, foreign_key: true
      t.string :event_title, null: false
      t.datetime :start_at, null: false
      t.datetime :end_at, null: false
      t.boolean  :all_day, default: false, null: false
      t.text     :description
      t.timestamps
    end
  end
end
