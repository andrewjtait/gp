# frozen_string_literal: true

class UserInfo
  attr_reader :name, :username, :password

  def initialize(name:, username:, password:)
    @name = name
    @username = username
    @password = password
  end
end
