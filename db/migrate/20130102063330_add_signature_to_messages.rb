class AddSignatureToMessages < ActiveRecord::Migration
  def self.up
    add_column :messages, :signature, :int
  end
  def self.down
  	remove_column :messages, :signature, :int
  end

end
