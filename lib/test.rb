# encoding: utf-8

require 'test/unit'
require 'xpointer'

class TestRule < Test::Unit::TestCase
  def initialize(*args)
    super
    
    @parser = XPointerGrammarParser.new
  end
  
  def test_valid_pointers
    rules = ["ebnf",
             "element(foo/1/3)",
             "element(/1/1)",
             "abc"
            ]
    
    rules.each do |rule|
      assert_not_nil(@parser.parse(rule), "Unable to parse: #{rule}")
    end
  end
end