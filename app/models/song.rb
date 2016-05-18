class Song < ActiveRecord::Base

  validates :title, presence: true, length: { maximum: 40 }
  validates :author, presence: true, length: { maximum: 25 }
  validates :url, length: { maximum: 140 }
  
end