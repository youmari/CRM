# frozen_string_literal: true

class CreateClients < ActiveRecord::Migration[7.0]
  def change
    create_table :clients do |t|
      t.string :first_name, null: false
      t.string :last_name, null: false
      t.string :email, null: false, index: { unique: true }
      t.string :stage, null: false, index: true, default: 'lead'
      t.string :phone_number
      t.integer :probability, default: 0
      t.references :company, index: true, foreign_key: true

      t.timestamps
    end
  end
end
