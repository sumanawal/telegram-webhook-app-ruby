# frozen_string_literal: true

class Emoji
  class << self
    def women_dancer
      '💃'
    end

    def men_dancer
      '🕺'
    end

    def comment
      '💬'
    end

    def pull_request_created
      '🐥'
    end

    def trophy
      '🏆'
    end

    def tick
      '✔'
    end

    def cross
      '❌'
    end

    def begin_mark
      '🔰'
    end

    def declined
      '💣'
    end

    def approved
      '👌'
    end

    def victory
      '✌'
    end

    def update
      '🤟'
    end

    def gem_emo
      '💎'
    end

    def smile
      '😀'
    end

    def comment_f
      '😥'
    end

    def cry
      '😭'
    end

    def chicken
      '🐓'
    end

    def fish
      '🐠'
    end

    def no_boy
      '🙅'
    end

    def ok_girl
      '🙆‍♀️'
    end

    def raise_hand
      '🙋'
    end

    def bow
      '🙇'
    end

    def registered
      '®'
    end

    def link
      '🔗'
    end

    def arrow
      '💘'
    end

    def right_arrow
      '➡'
    end

    def body_emoji(user)
      user.eql?('Shrijana Poudel') ? women_dancer : men_dancer
    end
  end
end

