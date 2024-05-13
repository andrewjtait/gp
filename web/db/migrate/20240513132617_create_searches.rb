# frozen_string_literal: true

class CreateSearches < ActiveRecord::Migration[7.0]
  def change
    create_table :searches do |t|
      t.datetime :next_appointment_at
      t.string :next_appointment_location
      t.string :next_appointment_doctor
      t.timestamps
    end
  end
end
