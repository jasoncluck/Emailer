# encoding: UTF-8
# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your
# database schema. If you need to create the application database on another
# system, you should be using db:schema:load, not running all the migrations
# from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20130411003307) do

  create_table "messages", :force => true do |t|
    t.string   "email"
    t.string   "subject"
    t.text     "body"
    t.boolean  "sent_flag"
    t.boolean  "receive_flag"
    t.date     "sent_time"
    t.date     "send_date",              
    t.date     "received_time"
    t.datetime "created_at",                                        :null => false
    t.datetime "updated_at",                                        :null => false
    t.string   "attachment_file_name"
    t.string   "attachment_content_type"
    t.integer  "attachment_file_size"
    t.datetime "attachment_updated_at"
    t.string   "cc"
    t.string   "bcc"
    t.integer  "signature"
  end

  create_table "signatures", :force => true do |t|
    t.string   "name"
    t.text     "signature"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "users", :force => true do |t|
    t.string   "email"
    t.string   "password_digest"
    t.datetime "created_at",                         :null => false
    t.datetime "updated_at",                         :null => false
    t.string   "auth_token"
    t.boolean  "admin",           :default => false
  end

end
