require 'treetop'
require 'xpointergrammar'    # This is a TreeTop generated file

class XPointer
  attr_accessor :pointer
  attr_accessor :pointer_parts
  
  def initialize(pointer)
    @pointer = pointer.to_s
    @pointer_parts = []
    
    parser = XPointerParser.new
    parse_tree_root = parser.parse(@pointer)
    parse_tree_root.populate(self)
  end
  
  def to_debug_string
    fields = ["iri", "scheme", "authority", "userinfo", "host", "port", "path", "query", "fragment", "reference_type"]
    fields.map {|f| "#{f}: #{self.send(f)}" }.join("\n")
  end
end

class SchemeName
  attr_reader :prefix
  attr_reader :suffix
  
  def initialize(prefix = nil, suffix)
    @prefix = prefix
    @suffix = suffix
  end
  
  def to_s
    if prefix
      "#{prefix}:#{suffix}"
    else
      "#{suffix}"
    end
  end
end

class PointerPart
  attr_reader :scheme_name
  attr_reader :scheme_data
  
  # scheme_name is a SchemeName object
  # scheme_data is a Hash
  def initialize(scheme_name, scheme_data)
    @scheme_name = scheme_name
    @scheme_data = scheme_data
  end
  
  def [](scheme_data_key)
    @scheme_data[scheme_data_key]
  end
end

def main
  pointer = XPointer.new("")
  puts pointer.to_s
end

main if $0 == __FILE__