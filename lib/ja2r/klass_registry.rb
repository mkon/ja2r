module JA2R
  module KlassRegistry
    extend self

    def instantiate(hash)
      lookup(hash['type']).new(hash)
    end

    def lookup(type)
      registry.fetch(type) { Element }
    end

    def register(type, klass)
      registry[type] = klass
    end

    private

    def registry
      @registry ||= {}
    end
  end
end
