class CreateOrders < ActiveRecord::Migration
  def self.up
    create_table :orders do |t|
      t.integer :client_id
      t.string :responsible
      t.string :address
      t.string :postal_code
      t.string :city
      t.string :town
      t.string :code
      t.date :date
      t.string :internal_code
      t.string :aasm_state

      t.timestamps
    end
  end

  def self.down
    drop_table :orders
  end
end
