# encoding: utf-8

#require 'xpointer'
require 'treetop'

def main
  Treetop.load "xpointergrammar"
  parser = XPointerParser.new
  node = parser.parse('element(intro/3/1)')
  if node
    puts 'valid syntax'
  else
    puts 'invalid syntax'
  end
end

main