# frozen_string_literal: true

class Client < ApplicationRecord
  belongs_to :company, counter_cache: true, optional: true

  STAGES = %w[contacted rejected closed diligence lead].freeze
  FILTER_PARAMS = %w[stage name].freeze

  validates :first_name, :last_name, :email, presence: true
  validates :email, uniqueness: true
  validates :probability, numericality: { greater_than_or_equal: 0, less_than_or_equal_to: 105 }
  validates_inclusion_of :stage, in: STAGES,
                                 message: "{{value}} must be in #{STAGES.join ','}"

  scope :by_stage, ->(stage) { where(stage:) if stage.present? }
  scope :by_name, ->(name) { where('clients.first_name ilike ?', "%#{name}%") }

  def self.filter(filters)
    Client.includes(:company)
          .by_stage(filters['stage'])
          .by_name(filters['name'])
  end
end
