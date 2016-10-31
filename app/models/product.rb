class Product < ApplicationRecord
    default_scope { order('title') }#set default order to alphabetical by title
    has_many :line_items
    before_destroy :ensure_not_referenced_by_any_line_item

    validates :title, :description, :image_url, :presence => true
    validates :price, :numericality => { :greater_than_or_equal_to => 0.01 }
    validates :title, :uniqueness => true 
    validates :image_url, :format => {
        :with => %r{\.(gif|jpg|png)$}i,
        :multiline => true,
        :message => 'must a URL for GIF, JPG or PNG image.'
    }

    def ensure_not_referenced_by_any_line_item
        if line_items.count.zero?
            # okay to delete product, if no corresponding line_items
            return true
        else
            errors.add(:base, 'Line Items present')
            return false
        end
    end
end
