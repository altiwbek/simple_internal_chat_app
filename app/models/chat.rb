# frozen_string_literal: true

# no doc
class Chat < ApplicationRecord

  has_many :chat_users, dependent: :destroy
  has_many :users, through: :chat_users
  # has_many :messages, dependent: :destroy
  has_many :chat_admins
  has_many :admins, class_name: 'User', through: :chat_admins

  has_many :messages do
    def recent
      order('id DESC').limit(10)
    end
  end

  accepts_nested_attributes_for :chat_users

  scope :with_unread_messages_of, lambda { |user|
    select(
      'distinct chats.*, ('\
      'select COUNT(messages.id) from messages '\
      'left join message_read_reports on message_read_reports.message_id = messages.id '\
      "where message_read_reports is null and messages.user_id != #{user.id} and messages.chat_id = chats.id "\
      ') as unread_messages_count, '\
      'coalesce( ( select messages.created_at from messages where  messages.chat_id = chats.id '\
      ' order by messages.id desc limit 1 ), chats.created_at ) as last_message_created_at '
    ).order('last_message_created_at desc')
  }

  scope :build_chat_list, lambda { |user|
    select(
      'distinct chats.*, ('\
      'select COUNT(messages.id) from messages '\
      'left join message_read_reports on message_read_reports.message_id = messages.id '\
      "where message_read_reports is null and messages.user_id != #{user.id} and messages.chat_id = chats.id "\
      ') as unread_messages_count, '\
      'coalesce(last_message.created_at, chats.created_at) as last_message_created_at, '\
      'last_message.last_text as last_text'
    ).joins(
      'left join ( '\
        'select messages.chat_id as chat_id, max(created_at) as created_at, '\
        '( select m.text_content from messages m where m.chat_id = messages.chat_id order by m.created_at desc limit 1 )'\
        ' as last_text from messages  group by messages.chat_id ' \
      ') as last_message on last_message.chat_id = chats.id'
    ).order('last_message_created_at desc')
  }

  def listing_title(user)
    if users.length > 2
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
    users.reject { |u| u.id == user.id }.first
  end
end
