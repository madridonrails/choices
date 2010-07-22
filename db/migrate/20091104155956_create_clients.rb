class CreateClients < ActiveRecord::Migration
  def self.up
    create_table :clients do |t|
      t.string :name
      t.string :cif
      t.string :address
      t.string :postal_code
      t.string :city
      t.string :town
      t.string :responsible
      t.integer :taxes
      t.integer :days_to_pay
      t.string :uneco
      t.string :provider_code
      t.integer :equivalence_surcharge

      t.timestamps
    end
  end

  def self.down
    drop_table :clients
  end
end
