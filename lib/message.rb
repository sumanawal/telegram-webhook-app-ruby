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
    body = "#{actual_action.gsub('_', ' ').capitalize} by:\n"
    body += "\t\t #{Emoji.body_emoji(actor)} <i><b>#{actor}</b></i>\n"
    body += "\n\t\t#{Emoji.comment}<a href='#{comment_url}'>comment</a>"
    body
  end

  def pullrequest_body
    body = "#{actual_action.gsub('_', ' ').capitalize} by:\n"
    user = action.eql?('pullrequest:created') ? author : actor
    body += "\t\t #{Emoji.body_emoji(user)} <i><b>#{user}</b></i>"
    body
  end

  def add_author
    return if action.eql?('pullrequest:created')

    "by <b>#{Emoji.pull_request_created} #{author}</b>"
  end
end
