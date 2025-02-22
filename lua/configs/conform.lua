local options = {
  formatters_by_ft = {
    lua = { "stylua" },
    -- css = { "prettier" },
    -- html = { "prettier" },
    -- python = { "isort", "black" },
    python = { "isort", "ruff_fix", "ruff_format" },
    yaml = { "prettier" },
    latex = { "bibtex-tidy", "tex-fmt", lsp_format = "fallback" }
  },

  -- format_on_save = {
  --   -- These options will be passed to conform.format()
  --   timeout_ms = 500,
  --   lsp_fallback = true,
  -- },
}

return options
