class ClientProductCustomization < ActiveRecord::Base

  belongs_to :product
  belongs_to :client

  validate :presence_of_price_or_code
  validates_presence_of :client_id
  validates_presence_of :product_id

  private

  def presence_of_price_or_code
    errors.add_to_base('wholesale_price_or_code_must_be_filled_in') if self.wholesale_price.blank? and self.code.blank?
  end

end
