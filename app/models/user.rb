class User < ApplicationRecord
        validates :name, :email, :password, presence: { message: :blank }
        validates :name, length: { in: 3..15 }
        validates :email, length: { in: 10..30 }, uniqueness: true
        validates :password, length: { minimum: 8 }
        encrypts :password   
end
