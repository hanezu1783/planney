# README

## userテーブル

| Column             | Type    | Options                   |
| ------------------ | ------- | ------------------------- |
| nickname           | string  | null: false               |
| email              | string  | null: false, unique: true |
| encrypted_password | string  | null: false               |

### Association

- has_many :transactions
- has_many :events

## transactionテーブル

| Column              | Type       | Options                        |
| --------------------| ---------- | ------------------------------ |
| user                | references | null: false, foreign_key: true |
| title               | string     | null: false                    |
| price               | integer    | null: false                    |
| date                | date       | null: false                    |
| transaction_type    | integer    | null: false                    |
| category_id         | integer    | null: false                    |
| pay_type            | integer    | null: false                    |
| memo                | text       |                                |


### Association

- belongs_to :user
- has_many :event_transactions
- has_many :events, through: :event_transactions


## eventテーブル

| Column              | Type       | Options                        |
| --------------------| ---------- | ------------------------------ |
| user                | references | null: false, foreign_key: true |
| event_title         | string     | null: false                    |
| start_at            | datetime   |                                |
| end_at              | datetime   |                                |
| all_day             | boolean    |                                |
| description         | text       |                                |

### Association

- belongs_to :user
- has_many :event_transactions
- has_many :transactions, through: :event_transactions

## event_transactionsテーブル

| Column              | Type       | Options                        |
| --------------------| ---------- | ------------------------------ |
| user                | references | null: false, foreign_key: true |
| event_id            | integer    | null: false                    |
| transaction_id      | integer    | null: false                    |

### Association

- belongs_to :user
- belongs_to :event
- belongs_to :transaction