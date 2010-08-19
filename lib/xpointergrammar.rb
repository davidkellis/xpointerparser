# Autogenerated from a Treetop grammar. Edits may be lost.


# grammar productions taken directly from Section 3.1 of http://www.w3.org/TR/xptr-framework/
module XPointerGrammar
  include Treetop::Runtime

  def root
    @root ||= :pointer
  end

  module Pointer0
    def populate(pointer)
      super
      pointer.reference_type = :scheme
    end
  end

  module Pointer1
    def populate(pointer)
      pointer.reference_type = :shorthand
    end
  end

  def _nt_pointer
    start_index = index
    if node_cache[:pointer].has_key?(index)
      cached = node_cache[:pointer][index]
      if cached
        cached = SyntaxNode.new(input, index...(index + 1)) if cached == true
        @index = cached.interval.end
      end
      return cached
    end

    i0 = index
    r1 = _nt_schemebased
    r1.extend(Pointer0)
    if r1
      r0 = r1
    else
      r2 = _nt_shorthand
      r2.extend(Pointer1)
      if r2
        r0 = r2
      else
        @index = i0
        r0 = nil
      end
    end

    node_cache[:pointer][start_index] = r0

    r0
  end

  def _nt_shorthand
    start_index = index
    if node_cache[:shorthand].has_key?(index)
      cached = node_cache[:shorthand][index]
      if cached
        cached = SyntaxNode.new(input, index...(index + 1)) if cached == true
        @index = cached.interval.end
      end
      return cached
    end

    r0 = _nt_ncname

    node_cache[:shorthand][start_index] = r0

    r0
  end

  module Schemebased0
    def pointerpart
      elements[1]
    end
  end

  module Schemebased1
    def first_pp
      elements[0]
    end

    def rest_pp
      elements[1]
    end
  end

  module Schemebased2
    def pointerparts
      [first_pp] + rest_pp.elements.map {|pair| pair.pointerpart }
    end
    
    def populate(pointer)
      pointerparts.each {|pp| pp.populate(pointer) }
    end
  end

  def _nt_schemebased
    start_index = index
    if node_cache[:schemebased].has_key?(index)
      cached = node_cache[:schemebased][index]
      if cached
        cached = SyntaxNode.new(input, index...(index + 1)) if cached == true
        @index = cached.interval.end
      end
      return cached
    end

    i0, s0 = index, []
    r1 = _nt_pointerpart
    s0 << r1
    if r1
      s2, i2 = [], index
      loop do
        i3, s3 = index, []
        r5 = _nt_s
        if r5
          r4 = r5
        else
          r4 = instantiate_node(SyntaxNode,input, index...index)
        end
        s3 << r4
        if r4
          r6 = _nt_pointerpart
          s3 << r6
        end
        if s3.last
          r3 = instantiate_node(SyntaxNode,input, i3...index, s3)
          r3.extend(Schemebased0)
        else
          @index = i3
          r3 = nil
        end
        if r3
          s2 << r3
        else
          break
        end
      end
      r2 = instantiate_node(SyntaxNode,input, i2...index, s2)
      s0 << r2
    end
    if s0.last
      r0 = instantiate_node(SyntaxNode,input, i0...index, s0)
      r0.extend(Schemebased1)
      r0.extend(Schemebased2)
    else
      @index = i0
      r0 = nil
    end

    node_cache[:schemebased][start_index] = r0

    r0
  end

  module Pointerpart0
    def elementschemedata
      elements[2]
    end

  end

  module Pointerpart1
    def populate(pointer)
      pointer.pointer_parts << PointerPart.new(SchemeName.new('element'), elementschemedata.text_value)
    end
  end

  module Pointerpart2
    def schemename
      elements[0]
    end

    def schemedata
      elements[2]
    end

  end

  module Pointerpart3
    def populate(pointer)
      pointer.pointer_parts << PointerPart.new(SchemeName.new(schemename.prefix, schemename.suffix), schemedata.text_value)
    end
  end

  def _nt_pointerpart
    start_index = index
    if node_cache[:pointerpart].has_key?(index)
      cached = node_cache[:pointerpart][index]
      if cached
        cached = SyntaxNode.new(input, index...(index + 1)) if cached == true
        @index = cached.interval.end
      end
      return cached
    end

    i0 = index
    i1, s1 = index, []
    if has_terminal?('element', false, index)
      r2 = instantiate_node(SyntaxNode,input, index...(index + 7))
      @index += 7
    else
      terminal_parse_failure('element')
      r2 = nil
    end
    s1 << r2
    if r2
      if has_terminal?('(', false, index)
        r3 = instantiate_node(SyntaxNode,input, index...(index + 1))
        @index += 1
      else
        terminal_parse_failure('(')
        r3 = nil
      end
      s1 << r3
      if r3
        r4 = _nt_elementschemedata
        s1 << r4
        if r4
          if has_terminal?(')', false, index)
            r5 = instantiate_node(SyntaxNode,input, index...(index + 1))
            @index += 1
          else
            terminal_parse_failure(')')
            r5 = nil
          end
          s1 << r5
        end
      end
    end
    if s1.last
      r1 = instantiate_node(SyntaxNode,input, i1...index, s1)
      r1.extend(Pointerpart0)
      r1.extend(Pointerpart1)
    else
      @index = i1
      r1 = nil
    end
    if r1
      r0 = r1
    else
      i6, s6 = index, []
      r7 = _nt_schemename
      s6 << r7
      if r7
        if has_terminal?('(', false, index)
          r8 = instantiate_node(SyntaxNode,input, index...(index + 1))
          @index += 1
        else
          terminal_parse_failure('(')
          r8 = nil
        end
        s6 << r8
        if r8
          r9 = _nt_schemedata
          s6 << r9
          if r9
            if has_terminal?(')', false, index)
              r10 = instantiate_node(SyntaxNode,input, index...(index + 1))
              @index += 1
            else
              terminal_parse_failure(')')
              r10 = nil
            end
            s6 << r10
          end
        end
      end
      if s6.last
        r6 = instantiate_node(SyntaxNode,input, i6...index, s6)
        r6.extend(Pointerpart2)
        r6.extend(Pointerpart3)
      else
        @index = i6
        r6 = nil
      end
      if r6
        r0 = r6
      else
        @index = i0
        r0 = nil
      end
    end

    node_cache[:pointerpart][start_index] = r0

    r0
  end

  module Elementschemedata0
    def ncname
      elements[0]
    end

  end

  def _nt_elementschemedata
    start_index = index
    if node_cache[:elementschemedata].has_key?(index)
      cached = node_cache[:elementschemedata][index]
      if cached
        cached = SyntaxNode.new(input, index...(index + 1)) if cached == true
        @index = cached.interval.end
      end
      return cached
    end

    i0 = index
    i1, s1 = index, []
    r2 = _nt_ncname
    s1 << r2
    if r2
      r4 = _nt_childsequence
      if r4
        r3 = r4
      else
        r3 = instantiate_node(SyntaxNode,input, index...index)
      end
      s1 << r3
    end
    if s1.last
      r1 = instantiate_node(SyntaxNode,input, i1...index, s1)
      r1.extend(Elementschemedata0)
    else
      @index = i1
      r1 = nil
    end
    if r1
      r0 = r1
    else
      r5 = _nt_childsequence
      if r5
        r0 = r5
      else
        @index = i0
        r0 = nil
      end
    end

    node_cache[:elementschemedata][start_index] = r0

    r0
  end

  module Childsequence0
  end

  def _nt_childsequence
    start_index = index
    if node_cache[:childsequence].has_key?(index)
      cached = node_cache[:childsequence][index]
      if cached
        cached = SyntaxNode.new(input, index...(index + 1)) if cached == true
        @index = cached.interval.end
      end
      return cached
    end

    s0, i0 = [], index
    loop do
      i1, s1 = index, []
      if has_terminal?('/', false, index)
        r2 = instantiate_node(SyntaxNode,input, index...(index + 1))
        @index += 1
      else
        terminal_parse_failure('/')
        r2 = nil
      end
      s1 << r2
      if r2
        if has_terminal?('\G[1-9]', true, index)
          r3 = true
          @index += 1
        else
          r3 = nil
        end
        s1 << r3
        if r3
          s4, i4 = [], index
          loop do
            if has_terminal?('\G[0-9]', true, index)
              r5 = true
              @index += 1
            else
              r5 = nil
            end
            if r5
              s4 << r5
            else
              break
            end
          end
          r4 = instantiate_node(SyntaxNode,input, i4...index, s4)
          s1 << r4
        end
      end
      if s1.last
        r1 = instantiate_node(SyntaxNode,input, i1...index, s1)
        r1.extend(Childsequence0)
      else
        @index = i1
        r1 = nil
      end
      if r1
        s0 << r1
      else
        break
      end
    end
    if s0.empty?
      @index = i0
      r0 = nil
    else
      r0 = instantiate_node(SyntaxNode,input, i0...index, s0)
    end

    node_cache[:childsequence][start_index] = r0

    r0
  end

  def _nt_schemename
    start_index = index
    if node_cache[:schemename].has_key?(index)
      cached = node_cache[:schemename][index]
      if cached
        cached = SyntaxNode.new(input, index...(index + 1)) if cached == true
        @index = cached.interval.end
      end
      return cached
    end

    r0 = _nt_qname

    node_cache[:schemename][start_index] = r0

    r0
  end

  def _nt_schemedata
    start_index = index
    if node_cache[:schemedata].has_key?(index)
      cached = node_cache[:schemedata][index]
      if cached
        cached = SyntaxNode.new(input, index...(index + 1)) if cached == true
        @index = cached.interval.end
      end
      return cached
    end

    s0, i0 = [], index
    loop do
      r1 = _nt_escapeddata
      if r1
        s0 << r1
      else
        break
      end
    end
    r0 = instantiate_node(SyntaxNode,input, i0...index, s0)

    node_cache[:schemedata][start_index] = r0

    r0
  end

  module Escapeddata0
    def schemedata
      elements[1]
    end

  end

  def _nt_escapeddata
    start_index = index
    if node_cache[:escapeddata].has_key?(index)
      cached = node_cache[:escapeddata][index]
      if cached
        cached = SyntaxNode.new(input, index...(index + 1)) if cached == true
        @index = cached.interval.end
      end
      return cached
    end

    i0 = index
    r1 = _nt_normalchar
    if r1
      r0 = r1
    else
      if has_terminal?('^(', false, index)
        r2 = instantiate_node(SyntaxNode,input, index...(index + 2))
        @index += 2
      else
        terminal_parse_failure('^(')
        r2 = nil
      end
      if r2
        r0 = r2
      else
        if has_terminal?('^)', false, index)
          r3 = instantiate_node(SyntaxNode,input, index...(index + 2))
          @index += 2
        else
          terminal_parse_failure('^)')
          r3 = nil
        end
        if r3
          r0 = r3
        else
          if has_terminal?('^^', false, index)
            r4 = instantiate_node(SyntaxNode,input, index...(index + 2))
            @index += 2
          else
            terminal_parse_failure('^^')
            r4 = nil
          end
          if r4
            r0 = r4
          else
            i5, s5 = index, []
            if has_terminal?('(', false, index)
              r6 = instantiate_node(SyntaxNode,input, index...(index + 1))
              @index += 1
            else
              terminal_parse_failure('(')
              r6 = nil
            end
            s5 << r6
            if r6
              r7 = _nt_schemedata
              s5 << r7
              if r7
                if has_terminal?(')', false, index)
                  r8 = instantiate_node(SyntaxNode,input, index...(index + 1))
                  @index += 1
                else
                  terminal_parse_failure(')')
                  r8 = nil
                end
                s5 << r8
              end
            end
            if s5.last
              r5 = instantiate_node(SyntaxNode,input, i5...index, s5)
              r5.extend(Escapeddata0)
            else
              @index = i5
              r5 = nil
            end
            if r5
              r0 = r5
            else
              @index = i0
              r0 = nil
            end
          end
        end
      end
    end

    node_cache[:escapeddata][start_index] = r0

    r0
  end

  module Normalchar0
    def unicodechar
      elements[1]
    end
  end

  def _nt_normalchar
    start_index = index
    if node_cache[:normalchar].has_key?(index)
      cached = node_cache[:normalchar][index]
      if cached
        cached = SyntaxNode.new(input, index...(index + 1)) if cached == true
        @index = cached.interval.end
      end
      return cached
    end

    i0, s0 = index, []
    i1 = index
    if has_terminal?('\G[()^]', true, index)
      r2 = true
      @index += 1
    else
      r2 = nil
    end
    if r2
      r1 = nil
    else
      @index = i1
      r1 = instantiate_node(SyntaxNode,input, index...index)
    end
    s0 << r1
    if r1
      r3 = _nt_unicodechar
      s0 << r3
    end
    if s0.last
      r0 = instantiate_node(SyntaxNode,input, i0...index, s0)
      r0.extend(Normalchar0)
    else
      @index = i0
      r0 = nil
    end

    node_cache[:normalchar][start_index] = r0

    r0
  end

  def _nt_unicodechar
    start_index = index
    if node_cache[:unicodechar].has_key?(index)
      cached = node_cache[:unicodechar][index]
      if cached
        cached = SyntaxNode.new(input, index...(index + 1)) if cached == true
        @index = cached.interval.end
      end
      return cached
    end

    if has_terminal?('\G[\\u0000-\\u10FFFF]', true, index)
      r0 = instantiate_node(SyntaxNode,input, index...(index + 1))
      @index += 1
    else
      r0 = nil
    end

    node_cache[:unicodechar][start_index] = r0

    r0
  end

  def _nt_s
    start_index = index
    if node_cache[:s].has_key?(index)
      cached = node_cache[:s][index]
      if cached
        cached = SyntaxNode.new(input, index...(index + 1)) if cached == true
        @index = cached.interval.end
      end
      return cached
    end

    s0, i0 = [], index
    loop do
      i1 = index
      if has_terminal?('\G[\\u0020]', true, index)
        r2 = true
        @index += 1
      else
        r2 = nil
      end
      if r2
        r1 = r2
      else
        if has_terminal?('\G[\\u0009]', true, index)
          r3 = true
          @index += 1
        else
          r3 = nil
        end
        if r3
          r1 = r3
        else
          if has_terminal?('\G[\\u000D]', true, index)
            r4 = true
            @index += 1
          else
            r4 = nil
          end
          if r4
            r1 = r4
          else
            if has_terminal?('\G[\\u000A]', true, index)
              r5 = true
              @index += 1
            else
              r5 = nil
            end
            if r5
              r1 = r5
            else
              @index = i1
              r1 = nil
            end
          end
        end
      end
      if r1
        s0 << r1
      else
        break
      end
    end
    if s0.empty?
      @index = i0
      r0 = nil
    else
      r0 = instantiate_node(SyntaxNode,input, i0...index, s0)
    end

    node_cache[:s][start_index] = r0

    r0
  end

  module Qname0
    def prefix
      nil
    end
    
    def suffix
      text_value
    end
  end

  def _nt_qname
    start_index = index
    if node_cache[:qname].has_key?(index)
      cached = node_cache[:qname][index]
      if cached
        cached = SyntaxNode.new(input, index...(index + 1)) if cached == true
        @index = cached.interval.end
      end
      return cached
    end

    i0 = index
    r1 = _nt_prefixedname
    if r1
      r0 = r1
    else
      r2 = _nt_unprefixedname
      r2.extend(Qname0)
      if r2
        r0 = r2
      else
        @index = i0
        r0 = nil
      end
    end

    node_cache[:qname][start_index] = r0

    r0
  end

  module Prefixedname0
    def pre
      elements[0]
    end

    def localpart
      elements[2]
    end
  end

  module Prefixedname1
    def prefix
      pre.text_value
    end
    
    def suffix
      localpart.text_value
    end
  end

  def _nt_prefixedname
    start_index = index
    if node_cache[:prefixedname].has_key?(index)
      cached = node_cache[:prefixedname][index]
      if cached
        cached = SyntaxNode.new(input, index...(index + 1)) if cached == true
        @index = cached.interval.end
      end
      return cached
    end

    i0, s0 = index, []
    r1 = _nt_prefix
    s0 << r1
    if r1
      if has_terminal?(':', false, index)
        r2 = instantiate_node(SyntaxNode,input, index...(index + 1))
        @index += 1
      else
        terminal_parse_failure(':')
        r2 = nil
      end
      s0 << r2
      if r2
        r3 = _nt_localpart
        s0 << r3
      end
    end
    if s0.last
      r0 = instantiate_node(SyntaxNode,input, i0...index, s0)
      r0.extend(Prefixedname0)
      r0.extend(Prefixedname1)
    else
      @index = i0
      r0 = nil
    end

    node_cache[:prefixedname][start_index] = r0

    r0
  end

  def _nt_unprefixedname
    start_index = index
    if node_cache[:unprefixedname].has_key?(index)
      cached = node_cache[:unprefixedname][index]
      if cached
        cached = SyntaxNode.new(input, index...(index + 1)) if cached == true
        @index = cached.interval.end
      end
      return cached
    end

    r0 = _nt_localpart

    node_cache[:unprefixedname][start_index] = r0

    r0
  end

  def _nt_prefix
    start_index = index
    if node_cache[:prefix].has_key?(index)
      cached = node_cache[:prefix][index]
      if cached
        cached = SyntaxNode.new(input, index...(index + 1)) if cached == true
        @index = cached.interval.end
      end
      return cached
    end

    r0 = _nt_ncname

    node_cache[:prefix][start_index] = r0

    r0
  end

  def _nt_localpart
    start_index = index
    if node_cache[:localpart].has_key?(index)
      cached = node_cache[:localpart][index]
      if cached
        cached = SyntaxNode.new(input, index...(index + 1)) if cached == true
        @index = cached.interval.end
      end
      return cached
    end

    r0 = _nt_ncname

    node_cache[:localpart][start_index] = r0

    r0
  end

  def _nt_ncname
    start_index = index
    if node_cache[:ncname].has_key?(index)
      cached = node_cache[:ncname][index]
      if cached
        cached = SyntaxNode.new(input, index...(index + 1)) if cached == true
        @index = cached.interval.end
      end
      return cached
    end

    r0 = _nt_name_without_colon

    node_cache[:ncname][start_index] = r0

    r0
  end

  module NameWithoutColon0
    def namechar
      elements[1]
    end
  end

  module NameWithoutColon1
    def namestartchar
      elements[1]
    end

  end

  def _nt_name_without_colon
    start_index = index
    if node_cache[:name_without_colon].has_key?(index)
      cached = node_cache[:name_without_colon][index]
      if cached
        cached = SyntaxNode.new(input, index...(index + 1)) if cached == true
        @index = cached.interval.end
      end
      return cached
    end

    i0, s0 = index, []
    i1 = index
    if has_terminal?(':', false, index)
      r2 = instantiate_node(SyntaxNode,input, index...(index + 1))
      @index += 1
    else
      terminal_parse_failure(':')
      r2 = nil
    end
    if r2
      r1 = nil
    else
      @index = i1
      r1 = instantiate_node(SyntaxNode,input, index...index)
    end
    s0 << r1
    if r1
      r3 = _nt_namestartchar
      s0 << r3
      if r3
        s4, i4 = [], index
        loop do
          i5, s5 = index, []
          i6 = index
          if has_terminal?(':', false, index)
            r7 = instantiate_node(SyntaxNode,input, index...(index + 1))
            @index += 1
          else
            terminal_parse_failure(':')
            r7 = nil
          end
          if r7
            r6 = nil
          else
            @index = i6
            r6 = instantiate_node(SyntaxNode,input, index...index)
          end
          s5 << r6
          if r6
            r8 = _nt_namechar
            s5 << r8
          end
          if s5.last
            r5 = instantiate_node(SyntaxNode,input, i5...index, s5)
            r5.extend(NameWithoutColon0)
          else
            @index = i5
            r5 = nil
          end
          if r5
            s4 << r5
          else
            break
          end
        end
        r4 = instantiate_node(SyntaxNode,input, i4...index, s4)
        s0 << r4
      end
    end
    if s0.last
      r0 = instantiate_node(SyntaxNode,input, i0...index, s0)
      r0.extend(NameWithoutColon1)
    else
      @index = i0
      r0 = nil
    end

    node_cache[:name_without_colon][start_index] = r0

    r0
  end

  module Name0
    def namestartchar
      elements[0]
    end

  end

  def _nt_name
    start_index = index
    if node_cache[:name].has_key?(index)
      cached = node_cache[:name][index]
      if cached
        cached = SyntaxNode.new(input, index...(index + 1)) if cached == true
        @index = cached.interval.end
      end
      return cached
    end

    i0, s0 = index, []
    r1 = _nt_namestartchar
    s0 << r1
    if r1
      s2, i2 = [], index
      loop do
        r3 = _nt_namechar
        if r3
          s2 << r3
        else
          break
        end
      end
      r2 = instantiate_node(SyntaxNode,input, i2...index, s2)
      s0 << r2
    end
    if s0.last
      r0 = instantiate_node(SyntaxNode,input, i0...index, s0)
      r0.extend(Name0)
    else
      @index = i0
      r0 = nil
    end

    node_cache[:name][start_index] = r0

    r0
  end

  def _nt_namestartchar
    start_index = index
    if node_cache[:namestartchar].has_key?(index)
      cached = node_cache[:namestartchar][index]
      if cached
        cached = SyntaxNode.new(input, index...(index + 1)) if cached == true
        @index = cached.interval.end
      end
      return cached
    end

    i0 = index
    if has_terminal?(":", false, index)
      r1 = instantiate_node(SyntaxNode,input, index...(index + 1))
      @index += 1
    else
      terminal_parse_failure(":")
      r1 = nil
    end
    if r1
      r0 = r1
    else
      if has_terminal?('\G[A-Z]', true, index)
        r2 = true
        @index += 1
      else
        r2 = nil
      end
      if r2
        r0 = r2
      else
        if has_terminal?("_", false, index)
          r3 = instantiate_node(SyntaxNode,input, index...(index + 1))
          @index += 1
        else
          terminal_parse_failure("_")
          r3 = nil
        end
        if r3
          r0 = r3
        else
          if has_terminal?('\G[a-z]', true, index)
            r4 = true
            @index += 1
          else
            r4 = nil
          end
          if r4
            r0 = r4
          else
            if has_terminal?('\G[\\u00C0-\\u00D6]', true, index)
              r5 = true
              @index += 1
            else
              r5 = nil
            end
            if r5
              r0 = r5
            else
              if has_terminal?('\G[\\u00D8-\\u00F6]', true, index)
                r6 = true
                @index += 1
              else
                r6 = nil
              end
              if r6
                r0 = r6
              else
                if has_terminal?('\G[\\u00F8-\\u02FF]', true, index)
                  r7 = true
                  @index += 1
                else
                  r7 = nil
                end
                if r7
                  r0 = r7
                else
                  if has_terminal?('\G[\\u0370-\\u037D]', true, index)
                    r8 = true
                    @index += 1
                  else
                    r8 = nil
                  end
                  if r8
                    r0 = r8
                  else
                    if has_terminal?('\G[\\u037F-\\u1FFF]', true, index)
                      r9 = true
                      @index += 1
                    else
                      r9 = nil
                    end
                    if r9
                      r0 = r9
                    else
                      if has_terminal?('\G[\\u200C-\\u200D]', true, index)
                        r10 = true
                        @index += 1
                      else
                        r10 = nil
                      end
                      if r10
                        r0 = r10
                      else
                        if has_terminal?('\G[\\u2070-\\u218F]', true, index)
                          r11 = true
                          @index += 1
                        else
                          r11 = nil
                        end
                        if r11
                          r0 = r11
                        else
                          if has_terminal?('\G[\\u2C00-\\u2FEF]', true, index)
                            r12 = true
                            @index += 1
                          else
                            r12 = nil
                          end
                          if r12
                            r0 = r12
                          else
                            if has_terminal?('\G[\\u3001-\\uD7FF]', true, index)
                              r13 = true
                              @index += 1
                            else
                              r13 = nil
                            end
                            if r13
                              r0 = r13
                            else
                              if has_terminal?('\G[\\uF900-\\uFDCF]', true, index)
                                r14 = true
                                @index += 1
                              else
                                r14 = nil
                              end
                              if r14
                                r0 = r14
                              else
                                if has_terminal?('\G[\\uFDF0-\\uFFFD]', true, index)
                                  r15 = true
                                  @index += 1
                                else
                                  r15 = nil
                                end
                                if r15
                                  r0 = r15
                                else
                                  if has_terminal?('\G[\\u10000-\\uEFFFF]', true, index)
                                    r16 = true
                                    @index += 1
                                  else
                                    r16 = nil
                                  end
                                  if r16
                                    r0 = r16
                                  else
                                    @index = i0
                                    r0 = nil
                                  end
                                end
                              end
                            end
                          end
                        end
                      end
                    end
                  end
                end
              end
            end
          end
        end
      end
    end

    node_cache[:namestartchar][start_index] = r0

    r0
  end

  def _nt_namechar
    start_index = index
    if node_cache[:namechar].has_key?(index)
      cached = node_cache[:namechar][index]
      if cached
        cached = SyntaxNode.new(input, index...(index + 1)) if cached == true
        @index = cached.interval.end
      end
      return cached
    end

    i0 = index
    r1 = _nt_namestartchar
    if r1
      r0 = r1
    else
      if has_terminal?("-", false, index)
        r2 = instantiate_node(SyntaxNode,input, index...(index + 1))
        @index += 1
      else
        terminal_parse_failure("-")
        r2 = nil
      end
      if r2
        r0 = r2
      else
        if has_terminal?(".", false, index)
          r3 = instantiate_node(SyntaxNode,input, index...(index + 1))
          @index += 1
        else
          terminal_parse_failure(".")
          r3 = nil
        end
        if r3
          r0 = r3
        else
          if has_terminal?('\G[0-9]', true, index)
            r4 = true
            @index += 1
          else
            r4 = nil
          end
          if r4
            r0 = r4
          else
            if has_terminal?('\G[\\u00B7]', true, index)
              r5 = true
              @index += 1
            else
              r5 = nil
            end
            if r5
              r0 = r5
            else
              if has_terminal?('\G[\\u0300-\\u036F]', true, index)
                r6 = true
                @index += 1
              else
                r6 = nil
              end
              if r6
                r0 = r6
              else
                if has_terminal?('\G[\\u203F-\\u2040]', true, index)
                  r7 = true
                  @index += 1
                else
                  r7 = nil
                end
                if r7
                  r0 = r7
                else
                  @index = i0
                  r0 = nil
                end
              end
            end
          end
        end
      end
    end

    node_cache[:namechar][start_index] = r0

    r0
  end

  def _nt_char
    start_index = index
    if node_cache[:char].has_key?(index)
      cached = node_cache[:char][index]
      if cached
        cached = SyntaxNode.new(input, index...(index + 1)) if cached == true
        @index = cached.interval.end
      end
      return cached
    end

    i0 = index
    if has_terminal?('\G[\\u0009]', true, index)
      r1 = true
      @index += 1
    else
      r1 = nil
    end
    if r1
      r0 = r1
    else
      if has_terminal?('\G[\\u000A]', true, index)
        r2 = true
        @index += 1
      else
        r2 = nil
      end
      if r2
        r0 = r2
      else
        if has_terminal?('\G[\\u000D]', true, index)
          r3 = true
          @index += 1
        else
          r3 = nil
        end
        if r3
          r0 = r3
        else
          if has_terminal?('\G[\\u0020-\\uD7FF]', true, index)
            r4 = true
            @index += 1
          else
            r4 = nil
          end
          if r4
            r0 = r4
          else
            if has_terminal?('\G[\\uE000-\\uFFFD]', true, index)
              r5 = true
              @index += 1
            else
              r5 = nil
            end
            if r5
              r0 = r5
            else
              if has_terminal?('\G[\\u10000-\\u10FFFF]', true, index)
                r6 = true
                @index += 1
              else
                r6 = nil
              end
              if r6
                r0 = r6
              else
                @index = i0
                r0 = nil
              end
            end
          end
        end
      end
    end

    node_cache[:char][start_index] = r0

    r0
  end

end

class XPointerGrammarParser < Treetop::Runtime::CompiledParser
  include XPointerGrammar
end