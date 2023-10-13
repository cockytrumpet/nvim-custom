local builtin = require "statuscol.builtin"
require("statuscol").setup {
  relculright = true,
  bt_ignore = {
    "nofile",
    "prompt",
    "temrinal",
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
    -- "vim",
    "alpha",
    "dashboard",
    "neo-tree",
    "Trouble",
    "noice",
    "lazy",
    "toggleterm",
  },
  segments = {
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
      },
      click = "v:lua.ScSa",
    },
    {
      text = { " ", builtin.lnumfunc, " " },
      click = "v:lua.ScLa",
      condition = { true, builtin.not_empty },
    },
    {
      sign = {
        namespace = { "gitsign*" },
        -- name = { ".*" },
        maxwidth = 1,
        colwidth = 1,
      },
      auto = false,
      click = "v:lua.ScSa",
    },
    {
      text = { " " },
    },
  },
}
