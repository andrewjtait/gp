# frozen_string_literal: true

require 'dotenv/load'
require 'selenium-webdriver'

require './lib/controller'

Controller.new(
  url: ENV['GP_URL'],
  name: ENV['NAME'],
  username: ENV['USERNAME'],
  password: ENV['PASSWORD']
).run
