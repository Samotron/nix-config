--[[return {
  {
    "nvim-treesitter/nvim-treesitter",
    config = function(_, opts)
      require("nvim-treesitter.configs").setup(opts)
      local parser_config = require("nvim-treesitter.parsers").get_parser_configs()
      parser_config.ags = {
        install_info = {
          url = "https://github.com/Samotron/tree-sitter-ags",
          files = { "src/parser.c" },
          branch = "main",
        },
        filetype = "ags",
      }
    end,
  },
{
    "nvim-treesitter/nvim-treesitter",
    opts = {
      ensure_installed = {
        "ags",
      },
    },
  },
}]]
--
