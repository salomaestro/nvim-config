require "nvchad.options"

-- Set global options
vim.o.cursorlineopt ='both' -- to enable cursorline!
vim.o.scrolloff = 10
vim.opt.relativenumber = true
vim.g.wiki_root = "~/wiki"
vim.o.formatexpr = "v:lua.require'conform'.formatexpr()"

-- Set vimtex options
vim.g.tex_flavour = "latex"
vim.g.vimtex_view_method = "skim"
vim.g.vimtex_view_skim_reading_bar = 1
vim.g.vimtex_view_skim_sync = 1
-- vim.g.vimtex_quickfix_mode = 0
vim.g.vimtex_compiler_method = "latexmk"
vim.g.vimtex_mappings_prefix = "å"
vim.g.complete_close_brackets = 1

-- Set luasnip path
local snippets = require "luasnip.loaders.from_lua"
snippets.load({ paths = "~/.config/nvim/lua/custom/snippets" })

-- Set window-local options
local highlight_group = vim.api.nvim_create_augroup("yankhighlight", { clear = true })
vim.api.nvim_create_autocmd("textyankpost", {
  callback = function()
    vim.highlight.on_yank()
  end,
  group = highlight_group,
  pattern = "*",
})

-- dap
require "dap"

local sign = vim.fn.sign_define

sign("DapBreakpoint", { text = "●", texthl = "DapBreakpoint", linehl = "", numhl = ""})
sign("DapBreakpointCondition", { text = "●", texthl = "DapBreakpointCondition", linehl = "", numhl = ""})
sign("DapLogPoint", { text = "◆", texthl = "DapLogPoint", linehl = "", numhl = ""})
sign('DapStopped', { text='', texthl='DapStopped', linehl='DapStopped', numhl= 'DapStopped' })

vim.api.nvim_create_autocmd("QuickFixCmdPost", {
  callback = function()
    local qf = vim.fn.getqflist({ size = 0 })
    if qf.size > 0 then
      vim.cmd("copen")
    end
  end,
  pattern = "*",
})

-- Surround

vim.api.nvim_create_autocmd("FileType", {
  pattern = "tex",
  callback = function()
    vim.b.surround_105 = "\\textit{" .. "\n" .. "}"
    vim.b.surround_101 = "\\emph{"   .. "\n" .. "}"
    vim.b.surround_102 = "\\textbf{" .. "\n" .. "}"
  end,
})
