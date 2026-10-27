class Apply < ApplicationRecord
  belongs_to :job #каждая заявка относится к одной вакансии
  belongs_to :geek #каждая заявка относится к одному соискателю

  #соискатель не может откликнуться на одну и ту же вакансию дважды
  # Проверка уникальности job_id в рамках geek_id
  validates :job_id, uniqueness: { scope: :geek_id, message: "вы уже откликнулись на эту вакансию" }
  validates :read, inclusion: { in: [true, false] } # поле read может принимать только значения true или false
  validates :invited, inclusion: { in: [true, false] }
end