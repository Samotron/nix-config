-- bootstrap lazy.nvim, LazyVim and your plugins
require("config.lazy")

local parser_config = require("nvim-treesitter.parsers").get_parser_configs()
parser_config.ags = {
  install_info = {
    url = "https://github.com/Samotron/tree-sitter-ags/tree/main",
    files = { "src/parser.c" },
  },
  filetype = "ags",
}
