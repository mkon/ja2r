module JA2R
  class InvalidData < RuntimeError
    def initialize(message, data)
      @data = data
      super(message)
    end

    attr_reader :data
  end
end
