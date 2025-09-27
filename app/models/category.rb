class Category < ActiveHash::Base
  # Transactionモデルとのアソシエーション
  include ActiveHash::Associations
  has_many :transactions
  self.data = [
    { id: 1, name: '---' },
    { id: 2, name: '食費' },
    { id: 3, name: '交通費' },
    { id: 4, name: '通信費' },
    { id: 5, name: '教育費' },
    { id: 6, name: 'レジャー' },
    { id: 7, name: 'その他' },
    { id: 8, name: '給与' },
    { id: 9, name: '賞与' },
    { id: 10, name: '投資' },
    { id: 11, name: '税金' },
  ]
end