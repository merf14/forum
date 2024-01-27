class Answer < ApplicationRecord
    validates :text, :user_id, :theme_id, presence: true
end
