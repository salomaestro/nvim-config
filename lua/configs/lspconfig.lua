-- load defaults i.e lua_lsp
local nvlsp = require "nvchad.configs.lspconfig"
local lspconfig = require "lspconfig"

nvlsp.defaults()

-- EXAMPLE
local servers = { "html", "cssls", "ruff", "jedi_language_server", "yls", "lua_ls" }

-- lsps with default config
for _, lsp in ipairs(servers) do
  lspconfig[lsp].setup {
    on_attach = nvlsp.on_attach,
    on_init = nvlsp.on_init,
    capabilities = nvlsp.capabilities,
  }
end

-- configuring single server, example: typescript
-- lspconfig.ts_ls.setup {
--   on_attach = nvlsp.on_attach,
--   on_init = nvlsp.on_init,
--   capabilities = nvlsp.capabilities,
-- }

lspconfig.ruff.setup({
  init_options = {
    settings = {
      lineLength = 88,
      indentStyle = "tab",
      lint = {
        select = {"E", "W", "F", "I", "B", "C4", "FURB"},
        ignore = {"F401", "W191"},
        preview = true,
      }
      -- Ruff language server settings go here
    }
  }
})

lspconfig.lua_ls.setup({
  settings = {
    Lua = {
      diagnostics = {
        globals = { "vim" },
      },
    },
  },
})
