local vim = vim
return {
  {
    "stevearc/conform.nvim",
    -- event = 'BufWritePre', -- uncomment for format on save
    opts = require "configs.conform",
    event = { "BufReadPre", "BufNewFile" },
  },

  -- These are some examples, uncomment them if you want to see them work!
  {
    "neovim/nvim-lspconfig",
    config = function()
      require "configs.lspconfig"
    end,
  },

  {
    "vim-test/vim-test",
    lazy = false,
    config = function()
      vim.g["test#use_quickfix"] = 1
      vim.g["test#strategy"] = "neovim_sticky"
      vim.g["test#python#runner"] = "pytest"
      vim.g["test#python#pytest#executable"] = "uv run pytest"
    end,
  },

  {
    "mfussenegger/nvim-dap",
    lazy = true,
  },

  {
    "lervag/wiki.vim",
    lazy = false,
  },

  {
    "lervag/vimtex",
    lazy = false,
  },

  {
    "jay-babu/mason-nvim-dap.nvim",
    opts = {
      handlers = {},
      automatic_installations = {
        exclude = {
          "python",
        },
      },
      ensure_installed = {
        "python",
      },
    },
    dependencies = {
      "mfussenegger/nvim-dap",
      "williamboman/mason.nvim",
    },
  },

  {
    "mfussenegger/nvim-dap-python",
    lazy = true,
    config = function()
      local python = vim.fn.expand "~/.local/share/nvim/mason/packages/debugpy/venv/bin/python"
      require("dap-python").setup(python)
    end,
    dependencies = {
      "mfussenegger/nvim-dap",
    },
  },

  {
    "theHamsta/nvim-dap-virtual-text",
    config = true,
    dependencies = {
      "mfussenegger/nvim-dap",
    },
  },

  {
    "rcarriga/nvim-dap-ui",
    config = true,
    dependencies = {
      "mfussenegger/nvim-dap",
      "mfussenegger/nvim-dap-python",
      "nvim-neotest/nvim-nio",
      "theHamsta/nvim-dap-virtual-text",
    },
  },

  {
    "mfussenegger/nvim-lint",
    lazy = true,
    event = { "BufReadPre", "BufNewFile" },
    config = function()
      require "configs.lint"
    end,
  },

  {
    "nvim-treesitter/nvim-treesitter",
    opts = {
      ensure_installed = {
        "vim",
        "lua",
        "python",
        "markdown",
        "latex",
      },
      highlight = {
        enable = true,
      },
    },
  },

  {
    "nvim-treesitter/nvim-treesitter-context",
    lazy = false,
    config = function()
      require("treesitter-context").setup {
        enable = true,
        max_lines = 0, -- No limit
      }
    end,
  },

  {
    "rktjmp/paperplanes.nvim",
    lazy = false,
    config = function()
      require("paperplanes").setup {
        provider = "dpaste.org",
      }
    end,
  },

  {
    "folke/persistence.nvim",
    event = "BufReadPre", -- this will only start session saving when an actual file was opened
  },

  {
    "NvChad/nvcommunity",
    { import = "nvcommunity.git.diffview" },
    -- { import = "nvcommunity.git.lazygit" },
    { import = "nvcommunity.completion.copilot" },
    {
      "copilot.lua",
      cmd = "Copilot",
      event = "InsertEnter",
      config = function()
        require("copilot").setup {
          suggestion = {
            enabled = true,
            auto_trigger = true,
            hide_during_completion = true,
            debounce = 75,
            keymap = {
              accept = "<M-a>",
              accept_word = false,
              accept_line = false,
              next = "<M-n>",
              prev = "<M-p>",
              dismiss = "<M-d>",
            },
          },
        }
      end,
    },
  },

  {
    "folke/trouble.nvim",
    opts = {}, -- for default options, refer to the configuration section for custom setup.
    cmd = "Trouble",
    keys = {
      {
        "<leader>tx",
        "<cmd>Trouble diagnostics toggle<cr>",
        desc = "Diagnostics (Trouble)",
      },
      {
        "<leader>tX",
        "<cmd>Trouble diagnostics toggle filter.buf=0<cr>",
        desc = "Buffer Diagnostics (Trouble)",
      },
      {
        "<leader>cs",
        "<cmd>Trouble symbols toggle focus=false<cr>",
        desc = "Symbols (Trouble)",
      },
      {
        "<leader>cl",
        "<cmd>Trouble lsp toggle focus=false win.position=right<cr>",
        desc = "LSP Definitions / references / ... (Trouble)",
      },
      {
        "<leader>tL",
        "<cmd>Trouble loclist toggle<cr>",
        desc = "Location List (Trouble)",
      },
      {
        "<leader>tQ",
        "<cmd>Trouble qflist toggle<cr>",
        desc = "Quickfix List (Trouble)",
      },
    },
  },

  {
    "tpope/vim-surround",
    lazy = false,
  },

  {
    "echasnovski/mini.nvim",
    version = "*",
    config = function()
      require("mini.diff").setup()
      require("mini.pick").setup()
    end,
  },

  {
    "olimorris/codecompanion.nvim",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-treesitter/nvim-treesitter",
    },
    config = function()
      require "configs.codecompanion"
    end,
    lazy = false,
  },

  {
    "max397574/better-escape.nvim",
    event = "InsertEnter",
    config = function()
      require("better_escape").setup()
    end,
  },

  {
    "aznhe21/actions-preview.nvim",
    keys = {
      {
        "<leader>gf",
        function()
          require("actions-preview").code_actions()
        end,
        mode = { "n", "v" },
        desc = "Show code actions",
        silent = true,
      },
    },
    config = function()
      require("actions-preview").setup {
        highlight_command = {
          require("actions-preview.highlight").delta(),
        },
      }
    end,
    lazy = false,
  },

  {
    "barreiroleo/ltex-extra.nvim",
    ft = { "markdown", "tex" },
    dependencies = { "neovim/nvim-lspconfig" },
  },
}
