class CreateInvoices < ActiveRecord::Migration
  def self.up
    create_table :invoices do |t|
      t.integer :order_id
      t.string :code
      t.date :date
      t.string :payment_method
      t.string :state
      t.string :expiration_date
      t.boolean :paid
      t.text :incidences

      t.timestamps
    end
  end

  def self.down
    drop_table :invoices
  end
end
