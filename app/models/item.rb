class Item < ApplicationRecord

  has_one_attached :image
  has_many :cart_items, dependent: :destroy
  has_many :order_list, dependent: :destroy

  validates :name, :introduction, :price, :image, presence: true

  def with_tax_price
    (price * 1.1).floor
  end

end
