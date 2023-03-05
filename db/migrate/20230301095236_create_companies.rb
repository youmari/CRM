# frozen_string_literal: true

class CreateCompanies < ActiveRecord::Migration[7.0]
  def change
    create_table :companies do |t|
      t.string :name, index: { unique: true }
      t.integer :clients_count, default: 0

      t.timestamps
    end
  end
end
