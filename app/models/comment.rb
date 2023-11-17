class Comment < ApplicationRecord
  #validates :content, presence: true
  #validates :prototype, presence: true
  #validates :user, presence: true
  belongs_to :user
  belongs_to :prototype
  validates :comment_content, presence: true
end
