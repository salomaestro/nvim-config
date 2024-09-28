require "nvchad.options"

-- add yours here!

local o = vim.o
local opt = vim.opt
-- o.cursorlineopt ='both' -- to enable cursorline!

o.scrolloff = 10
opt.relativenumber = true

local highlight_group = vim.api.nvim_create_augroup("yankhighlight", { clear = true })
vim.api.nvim_create_autocmd("textyankpost", {
  callback = function()
    vim.highlight.on_yank()
  end,
  group = highlight_group,
  pattern = "*",
})

