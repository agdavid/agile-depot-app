class Cart < ApplicationRecord
    has_many :line_items, :dependent => :destroy

    def add_product(product_id)
        current_item = line_items.where(:product_id => product_id).first
        if current_item
            # if searching for a line_item by the product_id results in a match
            # bump up the quantity
            current_item.quantity += 1
        else
            # build a new line_item
            current_item = line_items.build(:product_id => product_id)
        end
        current_item
    end

    def total_price
        self.line_items.to_a.sum { |item| item.total_price }
    end

    def total_items
        line_items.sum(:quantity)
    end
end
