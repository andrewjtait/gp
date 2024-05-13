# frozen_string_literal: true

class Appointment
  DATE_COLUMN_NUMBER = 1
  TIME_COLUMN_NUMBER = 2
  LOCATION_COLUMN_NUMBER = 4
  DOCTOR_COLUMN_NUMBER = 5
  TYPE_COLUMN_NUMBER = 6

  attr_reader :row

  def initialize(row)
    @row = row
  end

  def gp?
    type.include?('GP')
  end

  def datetime
    @datetime ||= DateTime.parse("#{date}T#{time}")
  end

  def date
    row.find_element(:css, "td:nth-child(#{DATE_COLUMN_NUMBER})").text
  end

  def time
    row.find_element(:css, "td:nth-child(#{TIME_COLUMN_NUMBER})").text
  end

  def location
    row.find_element(:css, "td:nth-child(#{LOCATION_COLUMN_NUMBER})").text
  end

  def doctor
    row.find_element(:css, "td:nth-child(#{DOCTOR_COLUMN_NUMBER})").text
  end

  def type
    row.find_element(:css, "td:nth-child(#{TYPE_COLUMN_NUMBER})").text
  end

  def to_h
    {
      datetime:,
      location:,
      doctor:,
      type:
    }
  end
end
