class Message < ActiveRecord::Base
  attr_accessible :body, :email, :subject, :sent_flag, :send_date, :sent_time, :receive_flag, :received_time, :attachment, :cc, :bcc
  #TODO: add form validators, email autocomplete
  has_attached_file :attachment, :stlyes => { :thumb => "100x100" } 
end
