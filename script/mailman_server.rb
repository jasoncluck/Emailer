#!/usr/bin/env ruby

require "rubygems"
require "bundler/setup"
require "mailman"

Mailman::Application.run do
  default do
    Message.create! subject: message.subject, email: message.from.first, body: message.body.decoded, receive_flag: true, sent_flag: false
  end
end