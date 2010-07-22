class CreateDeliveryNotes < ActiveRecord::Migration
  def self.up
    create_table :delivery_notes do |t|
      t.string :code
      t.integer :order_id
      t.integer :packages

      t.timestamps
    end
  end

  def self.down
    drop_table :delivery_notes
  end
end
