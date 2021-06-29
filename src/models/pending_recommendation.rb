require 'securerandom'
require_relative './base_model'

class PendingRecommendation < BaseModel
  attr_reader :recommended_by_user_name
  attr_reader :recommended_user_name

  def unique?
    entry = self.class
      .find_by('recommended_user_name', @recommended_user_name)
    entry.nil?
  end
end
