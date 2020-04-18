# frozen_string_literal: true
require './lib/config'
require './lib/git'
require './lib/emoji'
require './lib/telegram'
require './lib/message'

class Webhook
  attr_reader :action, :payload

  include Config
  include Git
  include Telegram
  include Message

  def initialize(action, payload)
    @action = action
    @payload = payload
  end

  def execute
    return if config[:send_message_for_master_only] && !master_branch?

    send_message_to_telegram(message)
  end
end
