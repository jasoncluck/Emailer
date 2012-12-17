class MessageMailer < ActionMailer::Base
	default :from => Figaro.env.sender_email
	def generic_email(message)
		mail(:to => message.email, :subject => message.subject, :body => message.body)
	end
end
