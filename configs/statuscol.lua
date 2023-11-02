local builtin = require "statuscol.builtin"
require("statuscol").setup {
  relculright = true,
  bt_ignore = {
    -- "nofile",
    "prompt",
    "terminal",
    "lazy",
  },
  ft_ignore = {
    "NvimTree",
    "dashboard",
    "nvcheatsheet",
    "dapui_watches",
    "dap-repl",
    "dapui_console",
    "dapui_stacks",
    "dapui_breakpoints",
    "dapui_scopes",
    "help",
    "vim",
    "Trouble",
    "noice",
    "lazy",
    "neotest-summary",
  },
  segments = {
    {
      sign = {
        namespace = { "gitsign*" },
        name = { ".*" },
        maxwidth = 2,
        colwidth = 2,
        wrap = true,
      },
      auto = false,
      click = "v:lua.ScSa",
    },
    {
      text = { builtin.foldfunc, " " },
      click = "v:lua.ScFa",
      condition = { true },
    },
    {
      sign = {
        name = { "Diagnostic" },
        maxwidth = 1,
        colwidth = 2,
        auto = false,
        wrap = true,
      },
      click = "v:lua.ScSa",
    },
    {
      text = { " ", builtin.lnumfunc, " " },
      click = "v:lua.ScLa",
      condition = { true, builtin.not_empty },
    },
  },
}
