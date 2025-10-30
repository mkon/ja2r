module JA2R
  class Element
    def initialize(origin_data, options = {})
      @origin_data = origin_data.with_indifferent_access
      @options = options
      @relationships = origin_data['relationships']&.then { |rd| convert_relationships(rd) } || {}
      build_references
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

    def build_references
      @references = {}.with_indifferent_access
      attributes&.each_key do |key|
        @references[key] ||= {attribute: key}
        @references[key.underscore] ||= {attribute: key}
      end
      relationships&.each_key do |key|
         @references[key] ||= {relationship: key}
         @references[key.underscore] ||= {relationship: key}
      end
    end

    def method_missing(symbol, *args)
      case @references[symbol]
      in attribute:
        attributes[attribute]
      in relationship:
        relationships[relationship]
      else
        safe_traverse? ? nil : super
      end
    end

    def respond_to_missing?(symbol, include_all = false)
      if @references.key? symbol
        true
      else
        safe_traverse? || super
        safe_traverse? ? true : super
      end
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
