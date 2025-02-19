require "nvchad.mappings"

-- add yours here

local vim = vim
local map = vim.keymap.set
local g = vim.g
local diag = vim.diagnostic

map("n", ";", ":", { desc = "CMD enter command mode" })
map("i", "jk", "<ESC>")

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

-- debug related stuff
local dap = require "dap"

map("n", "<leader>db", function()
  dap.toggle_breakpoint()
end, { desc = "Toggle breakpoint" })

map("n", "<leader>dc", function()
  dap.continue()
end, { desc = "Continue" })

map("n", "<leader>dr", function()
  dap.repl.open()
end, { desc = "Open REPL" })

map("n", "<leader>ds", function()
  dap.step_over()
end, { desc = "Step over" })

map("n", "<leader>di", function()
  dap.step_into()
end, { desc = "Step into" })

map("n", "<leader>do", function()
  dap.step_out()
end, { desc = "Step out" })

map("n", "<leader>dT", function()
  dap.terminate()
end, { desc = "Terminate" })

map("n", "<leader>dl", function()
  dap.run_last()
end, { desc = "Run Last" })

map("n", "<leader>dC", function()
  dap.run_to_cursor()
end, { desc = "Run to Cursor" })

-- dapui

local dapui = require "dapui"
local widgets = require "dap.ui.widgets"

map("n", "<leader>du", function()
  dapui.toggle()
end, { desc = "Toggle UI" })

map({ "n", "v" }, "<Leader>dh", function()
  widgets.hover()
end, { desc = "Hover" })

map({ "n", "v" }, "<Leader>dp", function()
  widgets.preview()
end, { desc = "Preview" })

map("n", "<Leader>df", function()
  widgets.centered_float(widgets.frames)
end, { desc = "Frames" })

map("n", "<Leader>ds", function()
  widgets.centered_float(widgets.scopes)
end, { desc = "Scopes" })

-- CodeCompletion mappings

map({ "n", "v" }, "<C-a>", "<cmd>CodeCompanionActions<cr>", { noremap = true, silent = true, desc = "Code Actions" })
map({ "n", "v" }, "<Leader>a", "<cmd>CodeCompanionChat Toggle<cr>", { noremap = true, silent = true, desc = "Code Chat" })
map("v", "ga", "<cmd>CodeCompanionChat Add<cr>", { noremap = true, silent = true, desc = "Code Chat Add Visual" })
map("v", "<Leader>ce", function()
  require("codecompanion").prompt("explain")
end, { noremap = true, silent = true, desc = "Explain Selection" }
)

-- Expand 'cc' into 'CodeCompanion' in the command line
vim.cmd([[cab cc CodeCompanion]])

-- mappings for wiki.vim
map("n", "<leader>iw", function ()
  require("telescope.builtin").live_grep({
    prompt_title = "Search Wiki",
    cwd = vim.fn.expand("~/wiki"),
  })
end, { desc = "Search Wiki" })

map("n", "<leader>jn", "<cmd>WikiJournalNext<cr>", { desc = "Next Journal" })
map("n", "<leader>jp", "<cmd>WikiJournalPrev<cr>", { desc = "Previous Journal" })
