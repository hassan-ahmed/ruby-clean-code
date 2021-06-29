require_relative './add_recommendation_interactor'
require_relative './accept_recommendation_interactor'

class ProcessRecommendationsInteractor
  def initialize(recommendations_input_parser:)
    @recommendations_input_parser = recommendations_input_parser
  end

  def call
    data = @recommendations_input_parser.call
    data.each do |row|
      action = 
        if row.action == 'recommends'
          AddRecommendationInteractor.new(
            recommended_by_user_name: row.user,
            recommended_user_name: row.recommended_user
          )
        elsif row.action == 'accepts'
          AcceptRecommendationInteractor.new(
            user_name: row.user
          )
        else
          raise 'Action not recognized'
        end

      action.call
    end
  end
end
