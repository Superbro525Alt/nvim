local on_attach = require("plugins.configs.lspconfig").on_attach
local capabilities = require("plugins.configs.lspconfig").capabilities

-- Setup lspconfig for various servers
local lspconfig = require "lspconfig"
local servers = { "html", "cssls", "tsserver", "clangd", "pyright", "yamlls", "tailwindcss", "rust_analyzer", "svelte" }

for _, lsp in ipairs(servers) do
  lspconfig[lsp].setup {
    on_attach = on_attach,
    capabilities = capabilities,
  }
end

