class Employee < ApplicationRecord
  belongs_to :company, counter_cache: true, optional: true

  STAGES = ['contacted', 'rejected', 'closed', 'diligence', 'lead']

  validates :first_name, :last_name, :email, presence: true
  validates :probability, numericality: { greater_than_or_equal: 0, less_than_or_equal_to: 105 }
  validates_inclusion_of :stage, :in => STAGES,
          :message => "{{value}} must be in #{STAGES.join ','}"
end
