module JA2R
  module KlassRegistry
    extend self

    def instantiate(hash, options)
      return unless hash&.key? 'type'

      lookup(hash['type']).new(hash, options)
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
