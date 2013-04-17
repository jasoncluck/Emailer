require 'open-uri'

class MessageMailer < ActionMailer::Base
	default :from => Figaro.env.sender_email,
			:conent_type => 'multipart/alternative',
			:parts_order => [ "text/html", "text/enriched", "text/plain", "application/pdf" ]
		def generic_email(message)
			#using open-uri
			if message.attachment?
	    		open(message.attachment.url, 'r') do |read_file|
	    			attachments[message.attachment_file_name] = read_file.read
	    		end
	    	end
		  
			mail(:to => message.email, :subject => message.subject, :body => message.body + "\n\n" + Signature.find(message.signature).signature, :cc => message.cc, :bcc => message.bcc)


	end
end
