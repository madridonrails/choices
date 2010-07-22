class Client < ActiveRecord::Base

  has_many :customizations, :class_name => 'ClientProductCustomization', :dependent => :destroy
  has_many :customized_products, :through => :customizations, :source => :product
  has_many :orders, :dependent => :nullify

  validates_presence_of :name
  validates_presence_of :cif
  validates_presence_of :taxes

  def initialize(*params)
    super(*params)
    self.taxes = DEFAULT_TAXES rescue nil if self.taxes.blank?
  end

  def complete_address
    address = ''
    address += self.address unless self.address.blank?
    address += " #{self.postal_code}" unless self.address.blank?
    address += " #{self.town}" unless self.town.blank?
    address += " (#{self.city})" unless self.city.blank?
  end

  def product_price(product)
    [self.customizations.find_by_product_id(product).wholesaleprice, product.wholesale_price].detect{|x| !x.nil?} rescue product.wholesale_price
  end

  def product_code(product)
    [self.customizations.find_by_product_id(product).code, product.code].detect{|x| !x.nil?} rescue product.code
  end
end
