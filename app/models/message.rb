class Message < ActiveRecord::Base
  attr_accessible :body, :email, :subject, :sent_flag, :send_date, :sent_date, :receive_flag
end
