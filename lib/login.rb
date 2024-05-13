# frozen_string_literal: true

class Login
  USERNAME_INPUT_IDENTIFIER = { name: 'Username' }.freeze
  PASSWORD_INPUT_IDENTIFIER = { name: 'Password' }.freeze
  SUBMIT_BUTTON_IDENTIFIER = { id: 'button' }.freeze

  attr_reader :driver, :user_info

  def self.run(driver, user_info)
    new(driver, user_info).run
  end

  def initialize(driver, user_info)
    @driver = driver
    @user_info = user_info
  end

  def run
    login
    select_patient
  end

  private

  def login
    driver.find_element(**USERNAME_INPUT_IDENTIFIER).send_keys(user_info.username)
    driver.find_element(**PASSWORD_INPUT_IDENTIFIER).send_keys(user_info.password)
    driver.find_element(**SUBMIT_BUTTON_IDENTIFIER).click
  end

  def select_patient
    driver.find_element(:xpath, "//*[contains(text(), '#{user_info.name}')]").click
  end
end
