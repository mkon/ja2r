require 'active_support/core_ext/array'
require 'active_support/core_ext/hash'

module JA2R
  autoload :Element,       'ja2r/element'
  autoload :KlassRegistry, 'ja2r/klass_registry'
  autoload :Parser,        'ja2r/parser'

  module_function

  def parse(hash)
    Parser.new(hash).call
  end

  def klass_for(hash)
    KlassRegistry.call(hash['type'])
  end
end
