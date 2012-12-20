#!/usr/bin/env ruby

require "rubygems"
require "bundler/setup"
require "mailman"

Mailman.config.poll_interval = 60

Mailman.config.pop3 = {
  server: 'pop.gmail.com', port: 995, ssl: true,
  username: "jcluck@gwmail.gwu.edu",
  password: "Offnofx23$"
}


Mailman::Application.run do
  default do
    Message.create! subject: message.subject, email: message.from.first, body: message.body.decoded, receive_flag: true, sent_flag: false
  end
end

