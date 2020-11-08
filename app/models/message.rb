class Message < ApplicationRecord
  belongs_to :chat
  has_many :message_read_reports
end
