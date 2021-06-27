require 'securerandom'

class User
  attr_reader :id
  attr_reader :recommended_by_user
  attr_reader :points

  def initialize
    @id = SecureRandom.uuid
    @points = 0
    @recommended_by_user = nil
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
end
