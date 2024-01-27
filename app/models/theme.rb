class Theme < ApplicationRecord
    validates :title, :text, :user_id, presence: true
    validates :title, length: { in: 5..90 }
end
