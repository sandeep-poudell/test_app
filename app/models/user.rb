class User < ApplicationRecord
  has_many :articles

  validates :username, presence: true, uniqueness: { case_sensitive: false }, length: {:minimum => 3, :maximum => 25}
  validates :email, presence: true, uniqueness: { case_sensitive: false }, length: {:maximum => 105}, format: { with: /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\z/i }

end