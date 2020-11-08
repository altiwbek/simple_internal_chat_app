# frozen_string_literal: true

# no doc
class Chat < ApplicationRecord

  has_many :chat_users, dependent: :destroy
  has_many :users, through: :chat_users
  has_many :messages, dependent: :destroy
  has_many :chat_admins
  has_many :admins, class_name: 'User', through: :chat_admins

  accepts_nested_attributes_for :chat_users

  scope :with_unread_messages, lambda {

  }

  def listing_title(user)
    p self
    if users.size > 2
      title
    else
      opposite_to(user)&.email || user&.email
    end
  end

  def self.new_with_admin(user, params)
    new_chat = new(params)
    new_chat.chat_users << ChatUser.new(user: user, chat: new_chat)
    new_chat.chat_admins << ChatAdmin.new(user: user, chat: new_chat)
    new_chat
  end

  def last_message
    messages.order(created_at: :desc).first
  end

  def opposite_to(user)
    users.joins(:chat_users).where.not(chat_users: {user: user}).first
  end
end
