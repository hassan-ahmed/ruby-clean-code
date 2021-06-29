require 'securerandom'
require_relative './base_model'

class User < BaseModel
  attr_reader :user_name
  attr_reader :recommended_by_user
  attr_reader :points

  def initialize(params = {})
    @recommended_by_user = nil
    @points = 0
    super(params)
  end

  def recommended_by(user)
    raise 'User was already recommended by someone' unless @recommended_by_user.nil?

    @recommended_by_user = user
  end

  def add_points(points)
    @points += points
  end

  def recommended_by?
    !@recommended_by_user.nil?
  end

  def unique?
    entry = self.class
      .find_by('user_name', @user_name)
    entry.nil?
  end
end
