class Job < ApplicationRecord
  belongs_to :company # каждая вакансия принадлежит одной компании
  # Внешний ключ company_id хранится в таблице jobs
  has_many :applies, dependent: :destroy
  has_many :geeks, through: :applies

  validates :name, presence: true, length: { minimum: 2 }
  validates :place, presence: true, inclusion: { in: ['Remote', 'Contract', 'Permanent'] } #место работы обязательно и должно быть одним из перечисленных значений
  validates :company_id, numericality: { only_integer: true } #company_id должен быть целым числом FK
end