class Company < ApplicationRecord
  has_many :jobs, dependent: :destroy
  has_many :applies, through: :jobs
  has_many :geeks, through: :applies

  validates :name, presence: true, length: { minimum: 2, maximum: 100 }
  validates :location, presence: true

  #  метод для мягкого удаления
  def delete_company
    update(deleted: true)
  end
end