# frozen_string_literal: true

require 'net/http'

class Search < ApplicationRecord
  validate :only_one_search, on: :create

  after_create :execute
  after_commit :notify

  def description
    return unless next_appointment_at.present?

    "#{next_appointment_at.strftime('%H:%M on %d/%m/%Y')} at #{next_appointment_location} with #{next_appointment_doctor}"
  end

  def execute
    Net::HTTP.post(URI.parse(ENV['SEARCH_URL']), nil)
  end

  private

  def only_one_search
    errors.add(:base, 'Only one search is allowed at a time') if Search.count.positive?
  end

  def notify
    return unless previous_changes.key?(:next_appointment_at)

    SendTextService.new(
      self,
      previous_time: previous_changes[:next_appointment_at][0],
      new_time: previous_changes[:next_appointment_at][1]
    ).execute
  end
end
