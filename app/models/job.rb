class Job < ApplicationRecord
  belongs_to :company
  has_many :applies, dependent: :destroy
  has_many :geeks, through: :applies

  validates :name, presence: true, length: { minimum: 2 }
  validates :place, presence: true, inclusion: { in: ['Remote', 'Contract', 'Permanent'] }
  validates :company_id, numericality: { only_integer: true }
end