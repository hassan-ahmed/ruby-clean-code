require_relative '../actions/process_recommendation_file'

class RecommendationsController
  def create
    uploaded_file_path = params[:file]

    res = ProcessRecommendationFile.call(
      file_path: uploaded_file_path
    )

    res
  end
end
