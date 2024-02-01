return {
  {
    "tjdevries/ocaml.nvim",
  },

  {
    "nvim-treesitter/nvim-treesitter",
    opts = function(_, opts)
      if type(opts.ensure_installed) == "table" then
        vim.list_extend(opts.ensure_installed, { "ocaml" })
      end
    end,
  },

  -- Add Clojure LSP server
  {
    "neovim/nvim-lspconfig",
    opts = {
      servers = {
        ocamllsp = { mason = false },
      },
    },
  },
}
