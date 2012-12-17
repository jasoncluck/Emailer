class AddSentFlagToMessages < ActiveRecord::Migration
  def change
    add_column :messages, :sent_flag, :boolean
  end
end
