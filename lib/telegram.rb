# frozen_string_literal: true

module Telegram
  def chat_id
    '-457596339'
  end

  def bot_id
    "980940855:AAG54PZ27YkIe9OxLxWsjw5J-YL5aCjBfbU"
  end

  def parse_mode
    'HTML'
  end

  def url
    "https://api.telegram.org/bot#{bot_id}/sendMessage"
  end

  def send_message_to_telegram(message)
    HTTParty.post(url, query: prepare_params(message))
  end

  def prepare_params(message)
    {
      chat_id: chat_id,
      parse_mode: parse_mode,
      text: message,
      disable_web_page_preview: false
    }
  end
end
