class Message < ActiveRecord::Base
  attr_accessible :body, :email, :subject, :sent_flag, :send_date, :sent_time, :receive_flag, :received_time, :attachment, :cc, :bcc, :signature
  validates :email, :subject, :presence => true
  validates_format_of :email, :with => /^(|(([A-Za-z0-9]+_+)|([A-Za-z0-9]+\-+)|([A-Za-z0-9]+\.+)|([A-Za-z0-9]+\++))*[A-Za-z0-9]+@((\w+\-+)|(\w+\.))*\w{1,63}\.[a-zA-Z]{2,6})$/i

  #TODO: email autocomplete

  has_attached_file :attachment, :stlyes => { :thumb => "100x100" } 
end
