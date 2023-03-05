# frozen_string_literal: true

class Company < ApplicationRecord
  has_many :clients

  validates :name, presence: true, uniqueness: true
end
