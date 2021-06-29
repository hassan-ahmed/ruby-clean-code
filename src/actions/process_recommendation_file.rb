require_relative '../parser/file_parser'
require_relative '../parser/recommendations_input_parser'
require_relative '../interactors/process_recommendations_interactor'
require_relative '../interactors/user_scores_interactor'

module ProcessRecommendationFile
  def self.call(file_path:)
    file_parser = FileParser.new(file_path: file_path)

    recommendations_input_parser = RecommendationsInputParser.new(
      input_parser: file_parser
    )

    ProcessRecommendationsInteractor.new(
      recommendations_input_parser: recommendations_input_parser
    ).call

    UserScoresInteractor.new(
    ).call
  end
end
