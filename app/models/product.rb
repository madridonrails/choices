class Product < ActiveRecord::Base

  has_many :customizations, :class_name => 'ClientProductCustomization', :dependent => :destroy
  has_many :customized_clients, :through => :customizations, :source => :client
  validates_presence_of :description
  validates_presence_of :wholesale_price
  validates_numericality_of :wholesale_price, :allow_nil => true, :greater_than => 0

  def price_for_client(client)
    [self.customizations.find_by_client_id(client).wholesale_price, self.wholesale_price].detect{|x| !x.nil?} rescue self.wholesale_price
  end

  def code_for_client(client)
    [self.customizations.find_by_client_id(client).code, self.code].detect{|x| !x.nil?} rescue self.code
  end
  
end
