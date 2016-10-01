class LineItem < ActiveRecord::Base
  belongs_to :order
  belongs_to :product

  def increment(qty)
    update(quantity: quantity + qty)
  end
end
