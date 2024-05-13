# frozen_string_literal: true

class ApiController < ApplicationController
  before_action :authenticate
  before_action :find_search

  skip_before_action :verify_authenticity_token

  def search
    if params[:appointments]&.any?
      appointment = params[:appointments][0]

      @search.update!(
        next_appointment_at: DateTime.parse(appointment[:datetime]),
        next_appointment_location: appointment[:location],
        next_appointment_doctor: appointment[:doctor]
      )
    end

    head :ok
  end

  private

  def authenticate
    authenticate_or_request_with_http_token do |token, _options|
      ActiveSupport::SecurityUtils.secure_compare(token, ENV['WEB_API_TOKEN'])
    end
  end

  def find_search
    @search = Search.first

    head :not_found if @search.nil?
  end
end
