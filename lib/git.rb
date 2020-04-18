# frozen_string_literal: true

module Git
  def target_branch
    payload['pullrequest']['destination']['branch']['name']
  end

  def source_branch
    'test source branch'
  end

  def master_branch?
    target_branch.eql? 'master'
  end

  def pullrequest_title
    'Currently test pr title'
  end

  def comment_message
    'test comment message'
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
    payload['pullrequest']['author']
  end

  def actor
    payload['actor']
  end

  def actual_action
    action.split(':')[1]
  end
end
