require 'securerandom'

class BaseModel
  @@db = {}

  @@list = []

  attr_reader :id

  def initialize(params = {})
    @id = SecureRandom.uuid
    @@db[self.class.name] ||= []
    params.each do |key, value|
      raise "Unknown attribute #{key}" unless respond_to?(key)
      instance_variable_set("@#{key}", value)
    end
  end

  def save
    return false unless unique?

    @@db[self.class.name] << self
    return true
  end


  def destroy
    @@db[self.class.name].delete_if do |entry|
      entry.id == @id
    end
  end

  class << self
    def all
      @@db[self.name] || []
    end

    def find_by(key, val)
      all.find do |entry|
        entry.send(key) == val
      end
    end

    def clear
      # @@db[self.name] = []
      @@db = {}
    end
  end
end
