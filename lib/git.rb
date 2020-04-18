# frozen_string_literal: true

module Git
  def target_branch
    payload['pullrequest']['destination']['branch']['name']
  end

  def source_branch
    payload['pullrequest']['source']['branch']['name']
  end

  def master_branch?
    target_branch.eql? 'master'
  end

  def pullrequest_title
    payload['pullrequest']['title']
  end

  def comment_message
    payload['comment']['content']['raw'][0..50]
  end

  def pullrequest_url
    payload['pullrequest']['links']['html']['href']
  end

  def comment_url
    payload['comment']['links']['html']['href']
  end

  def is_comment?
    ['comment_created', 'comment_updated', 'comment_deleted'].include? actual_action
  end

  def author
    payload['pullrequest']['author']['nickname']
  end

  def actor
    payload['actor']['nickname']
  end

  def actual_action
    action.split(':')[1]
  end
end
