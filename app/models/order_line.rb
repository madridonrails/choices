class OrderLine < ActiveRecord::Base

  validates_presence_of :quantity
  validates_presence_of :order_id
  validates_presence_of :product_id
  validates_presence_of :wholesale_price

  before_validation :set_prices_and_code
  
  belongs_to :order
  belongs_to :product

  def total_price
    self.wholesale_price * self.quantity
  end

  def set_prices_and_code
    self.wholesale_price = self.product.price_for_client(self.order.client) if read_attribute(:wholesale_price).blank?
    self.code = self.product.code_for_client(self.order.client) if read_attribute(:code).blank?
  end

end

