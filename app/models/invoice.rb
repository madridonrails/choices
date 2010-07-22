class Invoice < ActiveRecord::Base

  belongs_to :order

  validates_presence_of :date
  validates_presence_of :payment_method
  validates_presence_of :code

  def date=(date)
    write_attribute(:date, Date.strptime(date, DATE_FORMAT)) unless date.blank?
  end

  def order_code
    [order.code, order.internal_code].detect{|x| !x.blank?}
  end
end
