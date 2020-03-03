# frozen_string_literal: true

class Webhook
  attr_reader :payload, :action

  def initialize(action, payload)
    @action = action
    @payload = payload
  end

  def call
    send_message
  end

  private

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
    telegram_mapper["#{actor['nickname']}"]
  end

  def telegram_author
    telegram_mapper["#{author['nickname']}"]
  end

  def pullrequest_url
    payload['pullrequest']['links']['html']['href']
  end

  def prepare_message
    return default_message unless is_comment?
    default_message + comment_message
  end

  def default_message
    "=============================\n @#{telegram_actor} has perform #{action} \n Author: @#{telegram_author} \n Url: #{pullrequest_url}"
  end

  def comment_message
    "\n Comment Url: #{payload['comment']['links']['html']['href']}"
  end

  def is_comment?
    ['comment_created', 'comment_updated', 'comment_deleted'].include? action.split(':')[1]
  end

  def send_message
    url = "https://api.telegram.org/bot980940855:AAG54PZ27YkIe9OxLxWsjw5J-YL5aCjBfbU/sendMessage"
    params = { chat_id: "-457596339", parse_mode: 'HTML', text: "#{prepare_message}\n============================="}
    HTTParty.post(url, query: params)
  end
end
