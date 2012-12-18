class MessageMailer < ActionMailer::Base
	default :from => Figaro.env.sender_email
	def generic_email(message)
		#attachments["test.pdf"] = File.read(message.filepath)
		mail(:to => message.email, :subject => message.subject, :body => message.body)
	end
end
