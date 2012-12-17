class Message < ActiveRecord::Base
  attr_accessible :body, :email, :subject
end
