local overrides = require("custom.configs.overrides")

---@type NvPluginSpec[]
local plugins = {

  -- Override plugin definition options

  {
    "neovim/nvim-lspconfig",
    config = function()
      require "plugins.configs.lspconfig"
      require "custom.configs.lspconfig"
    end, -- Override to setup mason-lspconfig
  },

  -- override plugin configs
  {
    "williamboman/mason.nvim",
    opts = overrides.mason
  },

  {
    "nvim-treesitter/nvim-treesitter",
    opts = overrides.treesitter,
  },

  {
    "nvim-tree/nvim-tree.lua",
    opts = overrides.nvimtree,
  },

  -- Install a plugin
  {
    "max397574/better-escape.nvim",
    event = "InsertEnter",
    config = function()
      require("better_escape").setup()
    end,
  },

  {
    "stevearc/conform.nvim",
    --  for users those who want auto-save conform + lazyloading!
    -- event = "BufWritePre"
    config = function()
      require "custom.configs.conform"
    end,
  },

  {
    "mfussenegger/nvim-jdtls",
    -- config = function()
    --   vim.api.nvim_create_autocmd({ "FileType" }, {
    -- pattern = "java",
    -- callback = function()
    --     local jdtls = require("jdtls");
    --     jdtls.start_or_attach({
    --         capabilities = require("cmp_nvim_lsp").default_capabilities(),
    --         cmd = { vim.fn.expand("~/.local/share/nvim/mason/bin/jdtls") },
    --         root_dir = jdtls.setup.find_root({ "java-workspace" }),
    --     })
    --   end
    -- })
    --
    -- end
  },
  {'hrsh7th/cmp-nvim-lsp'},
  {'hrsh7th/nvim-cmp'}

  -- To make a plugin not be loaded
  -- {
  --   "NvChad/nvim-colorizer.lua",
  --   enabled = false
  -- },

  -- All NvChad plugins are lazy-loaded by default
  -- For a plugin to be loaded, you will need to set either `ft`, `cmd`, `keys`, `event`, or set `lazy = false`
  -- If you want a plugin to load on startup, add `lazy = false` to a plugin spec, for example
  -- {
  --   "mg979/vim-visual-multi",
  --   lazy = false,
  -- }
  --
}

return plugins
