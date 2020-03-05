# frozen_string_literal: true

class TargetBranch
  attr_reader :target_branch

  def initialize(pullrequest)
    @target_branch = pullrequest['destination']['branch']['name']
  end

  def send_message_for_master_only
    true
  end

  def master?
    target_branch.eql?('master')
  end
end
