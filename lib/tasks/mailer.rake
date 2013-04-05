require "mailman"


namespace :mailman do
  desc "Get recent emails"
  task :getemails => :environment do
  	#poll once for the newest emails
    Mailman.config.poll_interval = 0

	Mailman.config.pop3 = {
	  server: 'pop.gmail.com', port: 995, ssl: true,
	  username: Figaro.env.sender_email,
	  password: Figaro.env.sender_password
	}


	Mailman::Application.run do
	  default do
	   if message.date > Date.today << 1
	   		begin:
	    		Message.create! subject: message.subject, email: message.from.first, body: message.body.decoded, receive_flag: true, sent_flag: false, received_time: message.date
	    	rescue:	
	    end
	  end
	end
  end
end





