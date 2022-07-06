class Customer < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

         has_many :addresses, dependent: :destroy
         has_many :cart_items, dependent: :destroy
         has_many :orders, dependent: :destroy

         validates :first_name, :last_name, :first_name_kana, :last_name_kana,
            :main_address, :telephone_number,
            presence: true
         validates :postal_code, length: {is: 7}, numericality: { only_integer: true }
         validates :telephone_number, numericality: { only_integer: true }
         validates :first_name_kana, :last_name_kana,
              format: { with: /\A[\p{katakana}\p{blank}ー－]+\z/, message: "カタカナで入力して下さい。"}

         # 退会ステータスが退会の場合ログインできないようにするコード
         def active_for_authentication?
           super && (is_active == false)
         end

         def main_address_display
             '〒' + postal_code + ' ' + main_address + ' ' + last_name + ' ' + first_name
         end

end
