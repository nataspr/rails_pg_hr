class Geek < ApplicationRecord
  has_many :applies, dependent: :destroy
  has_many :jobs, through: :applies

  validates :name, presence: true
  validates :stack, presence: true
end
