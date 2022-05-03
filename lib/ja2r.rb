require 'active_support'
require 'active_support/core_ext/array'
require 'active_support/core_ext/hash'

module JA2R
  autoload :Element,       'ja2r/element'
  autoload :InvalidData,   'ja2r/invalid_data'
  autoload :KlassRegistry, 'ja2r/klass_registry'
  autoload :Parser,        'ja2r/parser'

  module_function

  def parse(hash, options = {})
    Parser.new(hash, options).call
  end

  def klass_for(hash)
    KlassRegistry.call(hash['type'])
  end
end
