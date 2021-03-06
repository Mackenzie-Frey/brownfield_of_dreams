class User < ApplicationRecord
  has_many :user_videos
  has_many :videos, through: :user_videos
  # has_many :friendees, foreign_key: :friendee_id, class_name: 'Friendship'
  # has_many :friends, through: :friendees
  has_many :friends, foreign_key: :friend_id, class_name: 'Friendship'
  has_many :friendees, through: :friends

  validates :email, uniqueness: true, presence: true
  validates_presence_of :password, on: :create
  validates_presence_of :first_name
  enum role: [:default, :admin]
  has_secure_password

  def token_valid?
    GithubService.new(self).status == 200
  end
end
