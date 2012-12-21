class Message < ActiveRecord::Base
  attr_accessible :body, :email, :subject, :sent_flag, :send_date, :sent_time, :receive_flag, :received_time
end
