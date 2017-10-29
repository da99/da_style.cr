
module DA_STYLE

  class Parser

    class Stack

      @index  : Int32 = 0
      @len    : Int32
      @origin : Array(String)

      getter opens        = [] of Symbol
      getter closes       = [] of Symbol
      getter previous     = [] of String

      def initialize(@origin)
        @len = @origin.size
      end # === def initialize

      def unshift(arr : Array(String))
        @origin[@index + 1, 0] = arr
        @len = @len + arr.size
      end # === def unshift

      def open?
        !@opens.empty?
      end

      def open
        @opens.last
      end

      def open(name : Symbol)
        @opens << name
      end

      def close
        val = @opens.pop
        @closes << val
        val
      end # === def close

      def close(expected : Symbol)
        actual = close
        if actual != expected
          raise Exception.new("Expecting to close #{expected}, but instead cloasing #{actual}")
        end
        actual
      end

      def fin?
        @index >= (@len - 1)
      end

      def move
        raise Exception.new("Can't move to next item. Finished.") if fin?
        @index += 1
        current
      end

      def current
        @origin[@index]
      end

      def assign(name : String, val : String)
        @assignments[name.upcase] = val
      end # === def assign

      def grab_partial(open : String, close : String, partial : Array(String))
        temp_opens = [] of String
        if current != open
          raise Exception.new("Can't grab partial to #{close.inspect} when not on #{open.inspect}")
        end

        loop do
          case current
          when open
            if !temp_opens.empty?
              partial << current
            end
            temp_opens << current
          when close
            temp_opens.pop
            if !temp_opens.empty?
              partial << current
            end
            break if temp_opens.empty?
          else
            partial << current
          end

          break if fin?
          move
        end

        if !temp_opens.empty?
          raise Exception.new("Missing closing #{close.inspect}")
        end

        return partial
      end # === def grab_partial

      def grab_through(str : String, arr : Array(String))
        while !fin? && current.index(str) == nil
          arr.push(current)
          move
        end

        if current == str
          return arr
        end

        if current.index(str) != nil
          arr.push current.rstrip(str)
          return arr
        end

        raise Exception.new("Missing token: #{str}")
      end

      def grab_until_token_is(token : String)
        while !fin? && current != token
          previous.push(current)
          move
        end
        if current != token
          raise Exception.new("Missing token: #{token}")
        end
        return previous
      end # === def grab_until_token_is

    end # === class Stack


  end # === class Parser

end # === module DA_STYLE