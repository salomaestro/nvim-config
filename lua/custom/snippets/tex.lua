local ls = require "luasnip"
local s = ls.snippet
local t = ls.text_node
local i = ls.insert_node

return {
  -- Italic snippet: type "it" in insert mode and expand to \textit{...}
  s({trig="it", desc="Insert italic text"}, {
    t "\\textit{",
    i(1, "text"),
    t "}",
  }),
  -- Bold snippet example:
  s({trig="bf", desc="Insert bold text"}, {
    t "\\textbf{",
    i(1, "text"),
    t "}",
  }),
  -- Emph snippet example:
  s({trig="em", desc="Insert emphasized text"}, {
    t "\\emph{",
    i(1, "text"),
    t "}",
  }),
}
