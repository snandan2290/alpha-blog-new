class User < ApplicationRecord

    before_save: {self.email = email.downcase}

    has_many :articles


    validates :email, presence: true, 
              uniqueness: true, 
              length: { minimum: 9 },
              format: { with: /[a-zA-Z0-9+_.-]+@[a-zA-Z0-9].[a-z]+/, message: "Invalid Email address" }
    validates :username, 
              presence: true, 
              uniqueness: true, 
              length: { minimum: 6, maximum:22 }
    validates :password, presence: true, length: {minimum:6, maximum:16}
end