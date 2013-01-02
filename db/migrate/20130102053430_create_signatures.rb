class CreateSignatures < ActiveRecord::Migration
  def self.up
    create_table :signatures do |t|
      t.string :name
      t.text :signature

      t.timestamps
    end
    Signature.create!(name: "GW Signature", signature: "GW Test")
    Signature.create!(name: "General Signature", signature: "General Test")
  end
  def self.down
  	drop_table :signatures
  end

end
