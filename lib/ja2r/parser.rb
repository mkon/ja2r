module JA2R
  class Parser
    def initialize(hash)
      @hash = hash
      @object_space = []
    end

    def call
      data = parse_data
      parse_included
      object_space.each do |object|
        assign_relationships object, object_map
      end
      data
    end

    private

    attr_reader :hash, :object_space

    def parse_data
      hash['data'].is_a?(Array) ? parse_list : parse_single
    end

    def parse_single
      root = Element.new hash['data']
      object_space << root
      root
    end

    def parse_list
      root = hash['data'].map { |data| Element.new data }
      object_space.push(*root)
      root
    end

    def parse_included
      hash['included']&.map do |data|
        object_space.push Element.new(data)
      end
    end

    def object_map
      object_space.each_with_object({}) do |obj, ha|
        ha.deep_merge! obj.type => {obj.id => obj}
      end
    end

    def assign_relationships(element, object_space)
      element.relationships.each do |key, relationship|
        if relationship.is_a? Array
          element.relationships[key] = relationship.map do |e|
            object_space.dig(e.type, e.id) || e
          end
        else
          next unless (obj = object_space.dig(relationship.type, relationship.id))

          element.relationships[key] = obj
        end
      end
    end
  end
end
