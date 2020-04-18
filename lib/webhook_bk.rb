# frozen_string_literal: true

class Webhook
  attr_reader :payload, :action

  ACTION_MAPPER = {
    'abc' => 'abc'
  }

  def initialize(action, payload)
    @action = action
    @payload = payload
  end

  def call
    return if send_message_for_master_only && !master?

    send_message
  end

  private

  def target_branch
    payload['pullrequest']['destination']['branch']['name']
  end

  def master?
    target_branch.eql?('master')
  end

  def send_message_for_master_only
    true
  end

  def actor
    payload['actor']
  end

  def author
    payload['pullrequest']['author']
  end

  def telegram_mapper
    {
      "Sushil" => "sushilsainju",
      "Bikram Suwal" => "bikramsuwal",
      "Shrijana Poudel" => "shrijanapoudel",
      "Suman Awal" => "Sumanawal",
      "Sushant Bajracharya" => "sussbuzz",
      "Saujan Maka" => "Saujan",
      "livanuj" => "livanuj",
      "dipzshr" => "dipzshr",
      "Amar Duwal" => "amarduwal"
    }
  end

  def telegram_actor
    telegram_mapper["#{actor['nickname']}"] || actor['nickname']
  end

  def telegram_author
    telegram_mapper["#{author['nickname']}"] || author['nickname']
  end

  def pullrequest_url
    payload['pullrequest']['links']['html']['href']
  end

  def prepare_message
    return default_message unless is_comment?
    default_message + comment_message
  end

  def default_message
    "@#{telegram_actor}: #{action} \n Author: @#{telegram_author} \n Url: <a href='#{pullrequest_url}'>PR</a>"
  end

  def comment_message
    "\n Comment Url: <a href=\"#{payload['comment']['links']['html']['href']}\">Comment</a>"
  end

  def is_comment?
    ['comment_created', 'comment_updated', 'comment_deleted'].include? action.split(':')[1]
  end

  def sticker
    base_url = 'https://github.com/sumanawal/telegram-stickers.github.io/raw/master/public/stickers/adventure-time'
    "#{base_url}/#{rand(1..23)}.png"
  end

  def actor_profile_image
    actor["links"]["avatar"]["href"]
  end

  def send_message
    url = "https://api.telegram.org/bot980940855:AAG54PZ27YkIe9OxLxWsjw5J-YL5aCjBfbU/sendMessage"
    msg = "#{prepare_message}"
    msg += "<a href='#{actor_profile_image}'>&#8205;</a>"
    params = {
      chat_id: "-457596339",
      parse_mode: 'HTML',
      text: msg,
      disable_web_page_preview: false
    }
    HTTParty.post(url, query: params)

    params = {
      chat_id: '-476373562',
      parse_mode: 'HTML',
      text: Message.new(payload)
    }
  end
end
