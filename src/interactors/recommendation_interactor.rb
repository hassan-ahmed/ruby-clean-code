require_relative './recommendation_points_interactor'

class RecommendationInteractor
  def initialize(recommended_by_user:, recommended_user:)
    @recommended_by_user = recommended_by_user
    @recommended_user = recommended_user
  end

  def call
    @recommended_user.recommended_by(@recommended_by_user)

    RecommendationPointsInteractor.new(
      user: @recommended_by_user
    ).call
  end
end
