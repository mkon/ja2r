module JA2R
  class Element
    def initialize(origin_data, options = {})
      @origin_data = origin_data.with_indifferent_access
      @options = options
      @relationships = origin_data['relationships'] ? convert_relationships(origin_data['relationships']) : {}
    end

    attr_reader :origin_data, :relationships

    def attribute(key)
      origin_data.dig 'attributes', key
    end

    def attributes
      origin_data['attributes']
    end

    def id
      origin_data['id']
    end

    def link(key)
      origin_data.dig 'links', key
    end

    def meta(key)
      origin_data.dig 'meta', key
    end

    # Support serializers
    alias read_attribute_for_serialization public_send

    alias serializable_hash origin_data

    def type
      origin_data['type']
    end

    private

    def method_missing(symbol, *args)
      return attributes[symbol] if attributes&.key? symbol
      return relationships[symbol] if relationships&.key? symbol

      safe_traverse? ? nil : super
    end

    def respond_to_missing?(symbol, include_all = false)
      return true if attributes&.key?(symbol)
      return true if relationships&.key?(symbol)

      safe_traverse? || super
    end

    def safe_traverse?
      @options[:safe_traverse]
    end

    def convert_relationships(hash)
      hash.each_with_object(ActiveSupport::HashWithIndifferentAccess.new) do |(key, data), memo|
        memo[key] = case data&.[]('data')
                    when Array
                      data['data'].map { |d| KlassRegistry.instantiate(d, @options) }
                    when Hash
                      KlassRegistry.instantiate(data&.[]('data'), @options)
                    end
      end
    end
  end
end
