class Apply < ApplicationRecord
  belongs_to :job
  belongs_to :geek

  validates :job_id, uniqueness: { scope: :geek_id, message: "вы уже откликнулись на эту вакансию" }
  validates :read, inclusion: { in: [true, false] }
  validates :invited, inclusion: { in: [true, false] }
end