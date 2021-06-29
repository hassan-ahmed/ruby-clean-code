class RecommendationRequestModel
  attr_reader :date_time
  attr_reader :user
  attr_reader :action
  attr_reader :recommended_user

  def initialize(params)
    params.each do |key, value|
      raise "Unknown attribute #{key}" unless respond_to?(key)
      instance_variable_set("@#{key}", value)
    end
  end
end
