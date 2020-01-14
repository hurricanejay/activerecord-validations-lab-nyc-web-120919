class Post < ActiveRecord::Base
    validates :title, presence: true
    validates :content, length: { minimum: 250 }
    validates :summary, length: { maximum: 250 }
    validates :category, inclusion: { in: %w(Fiction Non-FIction)}
    validate :is_clickbait?

    CLICKBAIT_KEYWORDS = [
        /Won't Believe/i,
        /Secret/i,
        /Top [0-9]*/,
        /Guess/i
    ]
    def is_clickbait?
        if CLICKBAIT_KEYWORDS.none? { |keywords| keywords.match title }
            errors.add(:title, "must be clickbait")
        end
    end
end
