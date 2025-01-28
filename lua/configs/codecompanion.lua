local cc = require "codecompanion"
cc.setup {
  adapters = {
    llama3 = function()
      return require("codecompanion.adapters").extend("ollama", {
        name = "llama3",
        schema = {
          model = {
            default = "llama3.1:latest",
          },
        },
      })
    end,
    mistral = function()
      return require("codecompanion.adapters").extend("ollama", {
        name = "mistral",
        schema = {
          model = {
            default = "mistral:latest",
          },
        },
      })
    end,
    qwen = function()
      return require("codecompanion.adapters").extend("ollama", {
        name = "qwen",
        schema = {
          model = {
            default = "qwen2.5-coder",
          },
        },
      })
    end,
  },
  strategies = {
    chat = {
      adapter = "copilot",
    },
    inline = {
      adapter = "copilot",
    },
  },
  display = {
    -- diff = {
    --   provider = "mini_diff",
    -- },
    action_palette = {
      provider = "mini_pick",
    },
  },
  opts = {
    log_level = "DEBUG",
  },
}
