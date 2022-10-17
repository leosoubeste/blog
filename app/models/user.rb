class User < ApplicationRecord
    has_many :posts

    validates :username, presence: true
    validates :email, presence: true
    validates :email, format: { with: /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\z/i }

    def blurred_email
        start = email.index('@') + 1
        the_end = email.rindex('.') - 1

        domain = email[start..the_end]

        email.gsub(domain, '*' * domain.length)
    end
end
