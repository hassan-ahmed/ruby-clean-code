require 'securerandom'

class User
  attr :id
  attr :recommended_by_user
  attr :points

  def initialize
    @id = SecureRandom.uuid
    @points = 0
    @recommended_by_user = nil
  end

  def recommended_by(user:)
    raise 'User was already recommended by someone' unless @recommended_by_user.nil?

    @recommended_by_user = user
    user.update_points(1.to_f)
  end

  def update_points(points)
    @points += points
    
    @recommended_by_user.update_points(points / 2.to_f) unless @recommended_by_user.nil?
  end
end
