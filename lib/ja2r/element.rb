module JA2R
  class Element
    def initialize(origin_data)
      @origin_data = origin_data.with_indifferent_access
      @relationships = origin_data['relationships'] ? convert_relationship(origin_data['relationships']) : {}
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

      super
    end

    def respond_to_missing?(symbol, include_all = false)
      return true if attributes&.key?(symbol)
      return true if relationships&.key?(symbol)

      super
    end

    def convert_relationship(hash)
      Hash[hash.map do |key, data|
        if data['data'].is_a? Array
          [key, data['data'].map { |d| KlassRegistry.instantiate(d) }]
        else
          [key, KlassRegistry.instantiate(data['data'])]
        end
      end].with_indifferent_access
    end
  end
end
