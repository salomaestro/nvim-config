-- load defaults i.e lua_lsp
local nvlsp = require "nvchad.configs.lspconfig"
local lspconfig = require "lspconfig"

nvlsp.defaults()

-- EXAMPLE
local servers = { "html", "cssls", "ruff", "jedi_language_server", "yls", "lua_ls", "texlab" }

-- lsps with default config
for _, lsp in ipairs(servers) do
  lspconfig[lsp].setup {
    on_attach = nvlsp.on_attach,
    on_init = nvlsp.on_init,
    capabilities = nvlsp.capabilities,
  }
end

-- lspconfig.texlab.setup({
--   settings = {
--     latex = {
--       build = {
--         executable = "latexmk",
--         args = { "-pdf", "-interaction=nonstopmode", "-synctex=1", "%f" },
--         onSave = true,
--       },
--     },
--   },
-- })

-- Set up LTeX separately
lspconfig.ltex.setup {
  on_init = nvlsp.on_init,
  capabilities = nvlsp.capabilities,

  on_attach = function(client, bufnr)
    -- Run NvChad's on_attach for your usual LSP keymaps
    nvlsp.on_attach(client, bufnr)

    require("ltex_extra").setup {
      load_langs = { "en-GB", "nb" },
      init_check = true,
      path = vim.fn.expand("~/.local/share/ltex"), -- where to store language dicts
    }
  end,

  settings = {
    ltex = {
      language = "en-GB",
      additionalLanguages = { "nb" },
    },
  },
}

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
