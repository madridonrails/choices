class Order < ActiveRecord::Base

  validates_presence_of :client_id
  validates_presence_of :date
  

  include AASM

  after_save :set_internal_code

  belongs_to :client
  has_many :order_lines, :dependent => :destroy
  has_one :delivery_note
  has_one :invoice

  aasm_initial_state :pendant

  aasm_state :pendant
  aasm_state :canceled
  aasm_state :with_incidences
  aasm_state :delivered

  aasm_event :cancel do
    transitions :to => :canceled, :from => [:pendant, :with_incidences, :delivered]
  end

  aasm_event :deliver do
    transitions :to => :delivered, :from => [:pendant, :with_incidences, :canceled]
  end

  aasm_event :mark_as_pendant do
    transitions :to => :pendant, :from => [:delivered, :with_incidences, :canceled]
  end

  aasm_event :mark_as_with_incidences do
    transitions :to => :with_incidences, :from => [:delivered, :pendant, :canceled]
  end

  def complete_address
    self.address + ' ' + self.postal_code + ' ' + self.town + ' ' + self.city
  end

  def price_before_taxes
    self.order_lines.inject(0) { |sum, obj | sum + (obj.quantity * obj.wholesale_price rescue 0)} unless self.order_lines.nil?
  end

  def total_wholesale_price
    taxes = self.client.taxes rescue DEFAULT_TAXES
    taxes += self.client.equivalence_surcharge rescue DEFAULT_EQUIVALENCE_SURCHARGE
    self.price_before_taxes + self.price_before_taxes * taxes * 0.01
  end

  def date=(date)
    write_attribute(:date, (Date.strptime(date, DATE_FORMAT) rescue ''))
  end

  private

  def set_internal_code
    if self.internal_code.blank?
      self.internal_code = ORDER_PREFIX + self.id.to_s + ORDER_SUFFIX
      self.save
    end
    
  end
end
