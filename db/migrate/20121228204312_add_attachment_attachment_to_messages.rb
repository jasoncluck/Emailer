class AddAttachmentAttachmentToMessages < ActiveRecord::Migration
  def self.up
    change_table :messages do |t|
      t.has_attached_file :attachment
    end
  end

  def self.down
    drop_attached_file :messages, :attachment
  end
end
