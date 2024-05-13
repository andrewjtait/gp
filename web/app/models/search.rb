# frozen_string_literal: true

require 'net/http'

class Search < ApplicationRecord
  validate :only_one_search

  after_create :execute

  def execute
    Net::HTTP.post(URI.parse(ENV['SEARCH_URL']), nil)
  end

  private

  def only_one_search
    errors.add(:base, 'Only one search is allowed at a time') if Search.count.positive?
  end
end
