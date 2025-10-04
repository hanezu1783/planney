class Category < ActiveHash::Base
  # Transactionモデルとのアソシエーション
  include ActiveHash::Associations
  has_many :transactions
  self.data = [
    { id: 1, name: '---' },
    { id: 2, name: '食費' },
    { id: 3, name: '交通費' },
    { id: 4, name: '通信費' },
    { id: 5, name: '光熱費' },
    { id: 6, name: '住居費' },
    { id: 7, name: '医療費' },
    { id: 8, name: '交際費' },
    { id: 9, name: '娯楽' },
    { id: 10, name: '日用品' },
    { id: 11, name: 'その他' },
  ]
end