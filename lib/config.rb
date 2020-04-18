# frozen_string_literal: true

module Config
  def config
    {
      send_message_for_master_only: true,
      tag_in_telegram: true
    }
  end
end
