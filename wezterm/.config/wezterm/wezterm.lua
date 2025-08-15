local wezterm = require 'wezterm'
local config = wezterm.config_builder()
config = {
  font_size = 13.0,
  enable_tab_bar = false,
  enable_scroll_bar = false,
  color_scheme = 'Brogrammer',
  font = wezterm.font 'JetBrains Mono',
  default_cursor_style = "BlinkingBar",
  front_end = "OpenGL",
  enable_wayland = false
}

return config
