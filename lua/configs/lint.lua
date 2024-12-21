local lint = require "lint"

lint.linters_by_ft = {
  python = { "ruff" },
  yaml = { "yamllint" },
  lua = { "selene" },
}

local ns = lint.get_namespace "ruff"
vim.diagnostic.config({ virtual_text = false, underline = false }, ns)

local lint_augroup = vim.api.nvim_create_augroup("lint", { clear = true })

-- vim.api.nvim_create_autocmd({ "BufEnter", "BufWritePost", "InsertLeave" }, {
--   group = lint_augroup,
--   callback = function()
--     lint.try_lint()
--   end,
-- })

vim.keymap.set("n", "<leader>ld", function()
  lint.try_lint()
end, { desc = "Trigger linting for current file" })
