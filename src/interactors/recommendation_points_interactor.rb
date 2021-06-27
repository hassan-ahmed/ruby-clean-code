class RecommendationPointsInteractor
  def initialize(user:)
    @user = user
  end

  def call
    add_points(user: @user, points: 1)
  end

  private

  def add_points(user:, points:)
    user.add_points(points)

    if user.recommended_by?
      add_points(
        user: user.recommended_by_user,
        points: points / 2.to_f
      )
    end
  end
end
