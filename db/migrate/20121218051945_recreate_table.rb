class RecreateTable < ActiveRecord::Migration
  def up
  	def change
  		drop_table :messages
		create_table :messages do |t|
	      t.string :email
	      t.string :subject
	      t.text :body
	      t.boolean :sent_flag
	      t.timestamps
	    end
  end
  end

  def down
  end
end
