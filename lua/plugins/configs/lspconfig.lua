-- Load on_attach and capabilities from the base LSP config
--
dofile(vim.g.base46_cache .. "lsp")
require "nvchad.lsp"

local M = {}
local utils = require "core.utils"

-- Define on_attach and capabilities
M.on_attach = function(client, bufnr)
  utils.load_mappings("lspconfig", { buffer = bufnr })

  if client.server_capabilities.signatureHelpProvider then
    require("nvchad.signature").setup(client)
  end

  if not utils.load_config().ui.lsp_semantic_tokens and client.supports_method "textDocument/semanticTokens" then
    client.server_capabilities.semanticTokensProvider = nil
  end
end

M.capabilities = vim.lsp.protocol.make_client_capabilities()

M.capabilities.textDocument.completion.completionItem = {
  documentationFormat = { "markdown", "plaintext" },
  snippetSupport = true,
  preselectSupport = true,
  insertReplaceSupport = true,
  labelDetailsSupport = true,
  deprecatedSupport = true,
  commitCharactersSupport = true,
  tagSupport = { valueSet = { 1 } },
  resolveSupport = {
    properties = {
      "documentation",
      "detail",
      "additionalTextEdits",
    },
  },
}

-- Setup lua_ls
require("lspconfig").lua_ls.setup {
  on_attach = M.on_attach,
  capabilities = M.capabilities,

  settings = {
    Lua = {
      diagnostics = {
        globals = { "vim" },
      },
      workspace = {
        library = {
          [vim.fn.expand "$VIMRUNTIME/lua"] = true,
          [vim.fn.expand "$VIMRUNTIME/lua/vim/lsp"] = true,
          [vim.fn.stdpath "data" .. "/lazy/ui/nvchad_types"] = true,
          [vim.fn.stdpath "data" .. "/lazy/lazy.nvim/lua/lazy"] = true,
        },
        maxPreload = 100000,
        preloadFileSize = 10000,
      },
    },
  },
}

-- require("lspconfig").jdtls.setup {
--   on_attach = M.on_attach,
--   capabilities = require("cmp_nvim_lsp").default_capabilities(),
--   cmd = { vim.fn.expand("~/.local/share/nvim/mason/bin/jdtls") },
--   root_dir = require('lspconfig').util.root_pattern('.git', 'pom.xml', 'build.gradle'),
--   settings = {
--     -- java = {
--     --   signatureHelp = { enabled = true },
--     --   import = { enabled = true },
--     --   rename = { enabled = true },
--     -- }
--   },
-- }

vim.api.nvim_create_autocmd({ "FileType" }, {
    pattern = "java",
    callback = function()
        local jdtls = require("jdtls");
        jdtls.start_or_attach({
            capabilities = require("cmp_nvim_lsp").default_capabilities(),
            cmd = { vim.fn.expand("~/.local/share/nvim/mason/bin/jdtls") },
            root_dir = jdtls.setup.find_root({ "java-workspace" }),
        })
    end
})


-- Export module
return M
