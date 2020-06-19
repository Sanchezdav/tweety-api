class Comment < ApplicationRecord
  belongs_to :user
  belongs_to :post

  validates :comment, presence: :true
  validates :comment, length: { maximum: 150 }
end
