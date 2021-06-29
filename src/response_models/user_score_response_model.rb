class UserScoreResponseModel
  attr_reader :user_name
  attr_reader :points

  def initialize(params)
    params.each do |key, value|
      raise "Unknown attribute #{key}" unless respond_to?(key)
      instance_variable_set("@#{key}", value)
    end
  end

  def as_json
    {
      user_name => points
    }
  end
end
