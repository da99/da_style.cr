
module DA_STYLE

  struct Hex_Color

    def initialize(val : String)
      val = case val
            when "black"
              "#000000"
            when "silver"
              "#c0c0c0"
            when "gray", "grey"
              "#808080"
            when "white"
              "#ffffff"
            when "green"
              "#008000"
            when "yellow"
              "#ffff00"
            when "red"
              "#ff0000"
            when "orange"
              "#ffa500"
            else
              val
            end

      if !val.match(/^#[a-zA-Z0-9]{6}([a-zA-Z0-9]{2})?$/)
        raise Exception.new("Invalid color: #{val.inspect}")
      end

      @val = val
    end # === def initialize

    def to_css
      @val
    end

  end # === class Color

end # === module DA_STYLE
