# frozen_string_literal: true

require './lib/appointment'

class FindAppointments
  BOOK_APPOINTMENT_SELECTOR = [:xpath, "//button[@type='submit'][contains(text(), 'Book Appointment')]"].freeze
  APPOINTMENT_TABLE_ROWS_SELECTOR = [:css, '#wrapper > table > tbody > tr'].freeze

  attr_reader :driver

  def self.run(driver)
    new(driver).run
  end

  def initialize(driver)
    @driver = driver
  end

  def run
    browse_appointments
    find_appointments
  end

  private

  def browse_appointments
    driver.find_element(*BOOK_APPOINTMENT_SELECTOR).click
  end

  def find_appointments
    appointment_rows = driver.find_elements(*APPOINTMENT_TABLE_ROWS_SELECTOR)[1..]
    return [] if appointment_rows.nil?

    appointment_rows.map do |row|
      appointment = Appointment.new(row)
      next unless appointment.gp?

      appointment
    end.compact
  end
end
