# frozen_string_literal: true

require './lib/user_info'
require './lib/login'
require './lib/find_appointments'

class Controller
  attr_reader :driver, :user_info, :appointments

  def initialize(url:, name:, username:, password:)
    @driver = Selenium::WebDriver.for(:firefox)
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

    puts "The next available appointment is #{appointments[0].description}."

    return if appointments.length == 1

    puts "\nThere are also the following appointments available:"
    appointments[1..].each do |appointment|
      puts "• #{appointment.description}"
    end
  end

  def finish
    log_appointments
    driver.quit
  end
end
