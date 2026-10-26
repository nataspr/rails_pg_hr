class Job < ApplicationRecord
  belongs_to :company
  has_many :applies, dependent: :destroy
  has_many :geeks, through: :applies

  validates :name, presence: true
  validates :place, presence: true
end