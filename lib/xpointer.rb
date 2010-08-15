require 'treetop'
require 'xpointergrammar'    # This is a TreeTop generated file

class XPointer
  attr_accessor :pointer
  
  def initialize(pointer)
    @pointer = pointer.to_s
    parser = XPointerParser.new
    parse_tree_root = parser.parse(@pointer)
    parse_tree_root.populate(self)
  end
  
  def to_debug_string
    fields = ["iri", "scheme", "authority", "userinfo", "host", "port", "path", "query", "fragment", "reference_type"]
    fields.map {|f| "#{f}: #{self.send(f)}" }.join("\n")
  end
end

def main
  pointer = XPointer.new("")
  puts pointer.to_s
end

main if $0 == __FILE__