require "nvchad.mappings"

-- add yours here

local map = vim.keymap.set
local g = vim.g
local diag = vim.diagnostic

map("n", ";", ":", { desc = "CMD enter command mode" })
map("i", "jk", "<ESC>")

-- map({ "n", "i", "v" }, "<C-s>", "<cmd> w <cr>")

map("n", "<leader>ca", function()
  vim.lsp.buf.code_action()
end, { desc = "LSP code action" })
map("n", "<leader>tt", function()
  require("base46").toggle_transparency()
end, { desc = "Toggle transparency" })

map("n", "J", "mzJ`z", { desc = "Concatenate line below cursor but does not move the cursor" })

map("n", "<leader>o", ':<c-u>call append(line("."),   repeat([""], v:count1))<cr>', { desc = "Insert line below" })
map("n", "<leader>O", ':<c-u>call append(line(".")-1,   repeat([""], v:count1))<cr>', { desc = "Insert line above" })

map("n", "<c-d>", "<c-d>zz")
map("n", "<c-u>", "<c-u>zz")

map("n", "<leader>lg", "<cmd> LazyGit<cr>", { desc = "LazyGit" })

-- Visual mode
map("v", "J", ":m '>+1<cr>gv=gv", { desc = "Move line w/indentation" })
map("v", "K", ":m '<-2<cr>gv=gv", { desc = "Move line w/indentation" })

map("v", ">", ">gv", { desc = "indent" })
map("v", "<", "<gv", { desc = "indent" })

-- Toggle diagnostics
g["diagnostics_active"] = true
function Toggle_diagnostics()
  if g.diagnostics_active then
    g.diagnostics_active = false
    diag.disable()
  else
    g.diagnostics_active = true
    diag.enable()
  end
end
map("n", "<leader>lt", Toggle_diagnostics, { noremap = true, silent = true, desc = "Toggle vim diagnostics" })

-- select a session to load
map("n", "<leader>qs", function()
  require("persistence").select()
end, { desc = "Select session to load" })

-- load the last session
map("n", "<leader>ql", function()
  require("persistence").load { last = true }
end, { desc = "Load last session" })

-- stop Persistence => session won't be saved on exit
map("n", "<leader>qd", function()
  require("persistence").stop()
end, { desc = "Stop persistence" })

-- tab related stuff
