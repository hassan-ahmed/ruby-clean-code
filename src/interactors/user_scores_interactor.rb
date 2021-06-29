require_relative '../models/user'
require_relative '../response_models/user_score_response_model'

class UserScoresInteractor
  def initialize
    # set params i.e. pagination, filters etc
  end

  def call
    res = {}
    users.map do |user|
      res[user.user_name] = user.points
    end
    res
  end

  private

  def build_response(user)
    UserScoreResponseModel.new({
      user_name: user.user_name,
      points: user.points
    }).as_json
  end

  def users
    User.all
  end
end
