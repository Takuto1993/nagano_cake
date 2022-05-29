class Customer < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

         has_many :addresses, dependent: :destroy
         has_many :cart_items, dependent: :destroy
         
         # 退会ステータスが退会の場合ログインできないようにするコード
         def active_for_authentication?
           super && (is_active == false)
         end
         
end
