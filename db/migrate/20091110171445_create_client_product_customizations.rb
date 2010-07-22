class CreateClientProductCustomizations < ActiveRecord::Migration
  def self.up
    create_table :client_product_customizations do |t|
      t.integer :product_id
      t.integer :client_id
      t.float :wholesale_price
      t.string :code

      t.timestamps
    end
  end

  def self.down
    drop_table :client_product_customizations
  end
end
