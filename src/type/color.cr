
require "./rgb_level"
require "./alpha"
require "./hue"

require "./hex_color"
require "./rgb_color"
require "./rgba_color"
require "./hsla_color"

module DA_STYLE

  alias Color = Hex_Color | RGB_Color | RGBA_Color | HSLA_Color

end # === module DA_STYLE
