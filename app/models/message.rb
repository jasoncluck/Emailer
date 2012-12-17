class Message < ActiveRecord::Base
  attr_accessible :body, :email, :subject, :sent_flag
end
