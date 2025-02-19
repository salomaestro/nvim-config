require "nvchad.options"

vim.o.cursorlineopt ='both' -- to enable cursorline!
vim.o.scrolloff = 10
vim.opt.relativenumber = true
vim.g.wiki_root = "~/wiki"

local highlight_group = vim.api.nvim_create_augroup("yankhighlight", { clear = true })
vim.api.nvim_create_autocmd("textyankpost", {
  callback = function()
    vim.highlight.on_yank()
  end,
  group = highlight_group,
  pattern = "*",
})

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
