require_relative '../models/pending_recommendation'
require_relative '../models/user'
require_relative './recommendation_points_interactor'

class AcceptRecommendationInteractor
  def initialize(user_name:)
    @user_name = user_name
  end

  def call
    recommendation = find_pending_recommendation
    return false if recommendation.nil?

    accept_recommendation(recommendation)
    true
  end

  private

  def accept_recommendation(recommendation)
    recommended_by_user = find_or_create_user(recommendation.recommended_by_user_name)
    recommended_user = find_or_create_user(recommendation.recommended_user_name)

    recommended_user.recommended_by(recommended_by_user)
    recommendation.destroy

    RecommendationPointsInteractor.new(
      user: recommended_by_user
    ).call
  end

  def find_pending_recommendation
    PendingRecommendation.find_by('recommended_user_name', @user_name)
  end

  def find_or_create_user(user_name)
    user = User.find_by('user_name', user_name)
    return user unless user.nil?

    User.new(user_name: user_name).save
    User.find_by('user_name', user_name)
  end
end
