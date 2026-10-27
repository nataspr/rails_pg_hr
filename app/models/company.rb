class Company < ApplicationRecord
  has_many :jobs, dependent: :destroy #у компании может быть много вакансий
  has_many :applies, through: :jobs # компания может быть связана со многими заявками (applies), но не напрямую, а через свои вакансии
  has_many :geeks, through: :applies #компания может быть связана со многими соискателями (geeks), которые откликнулись на её вакансии

  validates :name, presence: true, length: { minimum: 2, maximum: 100 } # поле name обязательно для заполнения и должно иметь длину от 2 до 100 символов
  validates :location, presence: true # обязательно для заполнения

  #  метод для мягкого удаления
  # устанавливает флаг deleted в значение true, чтобы запись можно было восстановить - bpvtytybz cjcnjzybz cfvjq rjvgfybb
  def delete_company
    update(deleted: true)
  end
end