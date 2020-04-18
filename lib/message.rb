# frozen_string_literal: true

module Message
  def message
    msg = header
    msg += is_comment? ? comment_body : pullrequest_body
    msg += footer
    msg
  end

  def header
    "#{Emoji.gem_emo} <b>#{pullrequest_title}</b> \n\t #{Emoji.arrow} <a href='#{pullrequest_url}'> Pull Request</a> #{add_author}\n\n "
  end

  def footer
    "\n Tags"
  end

  def comment_body
    body = "#{actual_action.gusb('_', ' ').capitalize} by:\n"
    body += "\t\t #{Emoji.body_emoji(actor)} #{actor}"
    body
  end

  def pullrequest_body
    body = "#{actual_action.gusb('_', ' ').capitalize} by:\n"
    user = action.eql?('pullrequest:created') ? author : actor
    body += "\t\t #{Emoji.body_emoji(user)} #{user}"
    body
  end

  def add_author
    return if action.eql?('pullrequest:created')

    "by <b>#{Emoji.pull_request_created} #{author}</b>"
  end
end
