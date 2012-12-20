#!/usr/bin/env ruby

require "rubygems"
require "bundler/setup"
require "mailman"

Mailman.config.poll_interval = 10

Mailman.config.imap = {
  server: 'imap.gmail.com', port: 993, ssl: true,
  username: "jcluck@gwmail.gwu.edu",
  password: "password"
}

Mailman::Application.run do
  default do
    Message.create! subject: message.subject, email: message.from.first, body: message.body.decoded, receive_flag: true, sent_flag: false
  end
end

