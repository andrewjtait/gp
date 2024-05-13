# frozen_string_literal: true

require './lib/web_client'
require './lib/user_info'
require './lib/login'
require './lib/find_appointments'

class Controller
  attr_reader :driver, :user_info, :appointments

  def initialize(url:, name:, username:, password:)
    @driver = initialize_driver(ENV['SELENIUM_REMOTE_URL'])
    @url = url
    @user_info = UserInfo.new(name:, username:, password:)
    @appointments = []
  end

  def run
    open_website
    login
    find_appointments
  ensure
    finish
  end

  private

  def initialize_driver(remote_url)
    if remote_url
      Selenium::WebDriver.for(:remote, url: remote_url, options: Selenium::WebDriver::Options.firefox)
    else
      Selenium::WebDriver.for(:firefox)
    end
  end

  def open_website
    driver.get(@url)
  end

  def login
    Login.run(driver, user_info)
  end

  def find_appointments
    @appointments = FindAppointments.run(driver)
  end

  def log_appointments
    return if appointments.empty?

    web_client.update(appointments)
  end

  def finish
    log_appointments
    driver.quit
  end

  def web_client
    @web_client ||= WebClient.new
  end
end
