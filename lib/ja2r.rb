require 'active_support/core_ext/array'
require 'active_support/core_ext/hash'

module JA2R
  autoload :Parser, 'ja2r/parser'

  module_function

  class Element
    def initialize(payload)
      @id = payload['id']
      @type = payload['type']
      @attributes = (payload['attributes'] || {}).with_indifferent_access
      @relationships = payload['relationships'] ? convert_relationship(payload['relationships']) : {}
    end

    attr_reader :id, :type, :attributes, :relationships

    private

    def method_missing(method, *args)
      return attributes[method] if attributes&.key? method
      return relationships[method] if relationships&.key? method
      super
    end

    def respond_to_missing?(symbol, include_all = false)
      return true if attributes&.key?(symbol.to_s)
      return true if relationships&.key?(symbol.to_s)
      super
    end

    def convert_relationship(hash)
      Hash[hash.map do |key, data|
        if data['data'].is_a? Array
          [key, data['data'].map { |d| Element.new(d) }]
        else
          [key, Element.new(data['data'])]
        end
      end].with_indifferent_access
    end
  end

  def parse(hash)
    Parser.new(hash).call
  end
end
