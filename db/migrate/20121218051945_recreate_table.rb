class RecreateTable < ActiveRecord::Migration
  	def up  		
		create_table :messages do |t|
	      t.string :email
	      t.string :subject
	      t.text :body
	      t.boolean :sent_flag
	      t.boolean :receive_flag
	      t.date :sent_time
	      t.date :send_date, :default => Date.today
	      t.date :received_time
	      t.timestamps

	  	end
 	end

  def down
	drop_table :messages
  end
end
