class LineItem < ApplicationRecord
    belongs_to :order, optional: true
    belongs_to :product
    belongs_to :cart

    def total_price
        self.product.price * self.quantity
    end
end
