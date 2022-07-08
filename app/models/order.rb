class Order < ApplicationRecord

  enum payment_method: {credit_card: 0, transfer: 1 }
  enum status: {入金待ち: 0, 入金確認: 1, 製作中: 2, 発送準備中: 3, 発送済: 4 }

  has_many :order_lists, dependent: :destroy
  belongs_to :customer

  validates :name, :address, :telephone_number,
            presence: true
  validates :postal_code, length: {is: 7}, numericality: { only_integer: true }
  validates :telephone_number, numericality: { only_integer: true }

end
