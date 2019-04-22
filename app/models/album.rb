class Album < ApplicationRecord
  validates :title, :year, presence: true
end
