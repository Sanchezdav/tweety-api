class Comment < ApplicationRecord
  belongs_to :user
  belongs_to :post, counter_cache: true

  validates :content, presence: :true
  validates :content, length: { maximum: 150 }
end
