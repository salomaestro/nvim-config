require "nvchad.mappings"

-- add yours here

local vim = vim
local map = vim.keymap.set
local g = vim.g
local diag = vim.diagnostic

--  General mappings
map("n", ";", ":", { desc = "CMD enter command mode" })
map("i", "jk", "<ESC>")

map("n", "j", "gj", { desc = "Move down" })
map("n", "k", "gk", { desc = "Move up" })

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

-- Presistence mappings
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


-- Mappings for Man using ripgrep
local actions = require("telescope.actions")
local action_state = require("telescope.actions.state")
local previewers = require("telescope.previewers")

-- Define a custom previewer that runs 'man' in a terminal job:
local man_previewer = previewers.new_termopen_previewer({
  get_command = function(entry)
    -- 'entry.value' will be the man-topic, e.g. "ls"
    if not entry or not entry.value then
      return { "echo", "" }
    end
    -- The pager string (col -bx | bat -l man -p) must be passed as one argument
    -- so that 'man' interprets it as a shell command for the pager:
    return {
      "man",
      "-P", "col -bx | bat -l man -p",  -- all as a single argument to -P
      entry.value
    }
  end,
})

-- Create a mapping that invokes Telescope with our custom previewer
map("n", "<leader>mp", function()
  require("telescope.builtin").find_files({
    prompt_title = "Man Pages",
    find_command = {
      "bash", "-c",
      table.concat({
        -- Pipeline:
        --   1) 'rg --files /usr/share/man'
        --   2) strip directory paths (xargs basename)
        --   3) remove trailing .x or .x.gz (sed)
        --   4) sort + unique
        "rg --files /usr/share/man",
        "| xargs basename",
        "| sed 's/\\.[^.]*$//'",
        "| sort -u",
      }, " ")
    },
    -- Provide our custom previewer
    previewer = man_previewer,

    -- 3) attach_mappings() lets us override what happens when we press <CR>
    attach_mappings = function(prompt_bufnr, map_telescope)
      local function open_man_page()
        local selection = action_state.get_selected_entry()
        actions.close(prompt_bufnr)
        -- Actually open the man page inside Neovim:
        vim.cmd("Man " .. selection.value)
      end

      -- Bind <CR> in insert + normal mode to open the man page
      map_telescope("i", "<CR>", open_man_page)
      map_telescope("n", "<CR>", open_man_page)

      return true
    end,
  })
end, { desc = "Search manpages" })

-- Mappings for Git stuff

-- Git blame
map("v", "<leader>gb", "<cmd>lua require('gitsigns').blame_line()<cr>", { desc = "Git Blame line" })
map("n", "<leader>gb", "<cmd>lua require('gitsigns').blame()<cr>", { desc = "Git Blame" })

-- Git diffview
map("n", "<leader>gd", "<cmd>DiffviewOpen<cr>", { desc = "Git Diff File" })
map("n", "<leader>gD", "<cmd>DiffviewOpen --cached<cr>", { desc = "Git Diff Staged" })
map("n", "<leader>gh", "<cmd>DiffviewFileHistory<cr>", { desc = "Git File History" })
