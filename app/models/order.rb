class Order < ApplicationRecord
    has_many :line_items, :dependent => :destroy

    PAYMENT_TYPES = ["Check", "Credit card", "Purchase order"]

    validates :name, :address, :email, :pay_type, :presence => true
    validates :pay_type, :inclusion => PAYMENT_TYPES

    def add_line_items_from_cart(cart)
        # populate order.line_items
        cart.line_items.each do |item|
            #remove association with cart to avoid destruction on emptying of cart
            item.cart_id = nil
            line_items << item
        end
    end
end
