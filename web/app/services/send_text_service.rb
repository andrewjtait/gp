class SendTextService
  attr_reader :search

  def initialize(search, previous_time:, new_time:)
    @search = search
    @previous_time = previous_time
    @new_time = new_time
    @sender = ENV['TWILIO_SENDER']
    @recipients = ENV['TWILIO_RECIPIENTS'].split(',')
  end

  def execute
    return unless @previous_time.nil? || @previous_time < @new_time

    @recipients.each do |recipient|
      twilio_client.messages.create(body: message, from: @sender, to: recipient)
    end
  end

  private

  def message
    return @message if @message.present?

    @message = if @previous_time.nil?
                 "🧑‍⚕️ The earliest GP appointment is #{search.description}."
               else
                 "🧑‍⚕️ There is now an earlier GP appointment for #{search.description}."
               end
    @message += "\n\nWe'll keep searching for earlier appointments!"
    @message += "\n\nBook this appointment: #{ENV['GP_URL']}"
    @message += "\n\nor stop searching: #{stop_url}"

    @message
  end

  def twilio_client
    @twilio_client ||= Twilio::REST::Client.new(ENV['TWILIO_ACCOUNT_SID'], ENV['TWILIO_AUTH_TOKEN'])
  end

  def stop_url
    Rails.application.routes.url_helpers.stop_search_url(host: ENV['HOST'])
  end
end
