require 'treetop'
require 'xpointergrammar'    # This is a TreeTop generated file

#Treetop.load "xpointergrammar"

class XPointer
  attr_accessor :pointer
  attr_accessor :pointer_parts
  attr_accessor :reference_type
  
  def initialize(pointer)
    @pointer = pointer.to_s
    @pointer_parts = []
    
    parser = XPointerGrammarParser.new
    parse_tree_root = parser.parse(@pointer)
    parse_tree_root.populate(self)
  end
  
  def to_debug_string
    fields = ["pointer", "pointer_parts", "reference_type"]
    fields.map {|f| "#{f}: #{self.send(f)}" }.join("\n")
  end
  
  def shorthand?
    reference_type == :shorthand
  end
  
  def to_s
    if shorthand?
      pointer
    else
      pointer_parts.join("\n")
    end
  end
end

class PointerPart
  attr_reader :scheme_name
  attr_reader :scheme_data
  
  # scheme_name is a SchemeName object
  def initialize(scheme_name, scheme_data)
    @scheme_name = scheme_name
    @scheme_data = scheme_data
  end
  
  def to_s
    "#{scheme_name}(#{scheme_data})"
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

def main
  pointer = XPointer.new("element(intro/3/1)element(foo/bar/baz)")
  puts pointer.to_s
end

main if $0 == __FILE__