class Company < ApplicationRecord
  has_many :jobs, dependent: :destroy
  has_many :applies, through: :jobs

  validates :name, presence: true
  validates :location, presence: true
end
