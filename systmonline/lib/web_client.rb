# frozen_string_literal: true

require 'net/http'

class WebClient
  attr_reader :uri, :https

  def initialize
    @uri = URI.parse(ENV['WEB_API_URL'])
    @https = Net::HTTP.new(uri.host, uri.port)
  end

  def update(appointments)
    post({ appointments: appointments.map(&:to_h) })
  end

  private

  def post(body)
    request = Net::HTTP::Post.new(
      uri,
      {
        'Content-Type' => 'application/json',
        'Authorization' => "Bearer #{ENV['WEB_API_TOKEN']}"
      }
    )
    request.body = body.to_json
    https.request(request)
  end
end
