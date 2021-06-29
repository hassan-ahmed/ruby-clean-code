require_relative '../models/pending_recommendation'

class AddRecommendationInteractor
  def initialize(recommended_by_user_name:, recommended_user_name:)
    @recommended_by_user_name = recommended_by_user_name
    @recommended_user_name = recommended_user_name
  end

  def call
    pending_recommendation = PendingRecommendation.new(
      recommended_by_user_name: @recommended_by_user_name,
      recommended_user_name: @recommended_user_name
    )
    pending_recommendation.save
  end
end
