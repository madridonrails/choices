class DeliveryNote < ActiveRecord::Base

  belongs_to :order

  validates_presence_of :order_id
  validates_presence_of :code
  validates_presence_of :packages

  def order_code
    [order.code, order.internal_code].detect{|x| !x.blank?}
  end

end
