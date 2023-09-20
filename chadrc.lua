---@type ChadrcConfig
local M = {}

-- Path to overriding theme and highlights files
local highlights = require "custom.highlights"

M.ui = {
  statusline = {
    theme = "vscode_colored", -- default/vscode/vscode_colored/minimal

    -- default/round/block/arrow (separators work only for "default" statusline theme;
    -- round and block will work for the minimal theme only)
    separator_style = "round",
    overriden_modules = nil,
  },

  theme = "catppuccin",
  theme_toggle = { "tokyonight", "catppuccin" },
  lsp_semantic_tokens = false,
  hl_override = highlights.override,
  hl_add = highlights.add,

  cmp = {
    icons = true,
    lspkind_text = true,
    style = "flat_dark", -- default/flat_light/flat_dark/atom/atom_colored
  },

  lsp = {
    signature = {
      disabled = true,
      silent = true,
    },
  },

  telescope = { style = "bordered" },

  extended_integrations = {
    "dap",
    "notify",
    "rainbowdelimiters",
    "codeactionmenu",
    "todo",
    "trouble",
    "notify",
  },
}

M.settings = {
  cc_size = "130",
  so_size = 10,

  -- Blacklisted files where cc and so must be disabled
  blacklist = {
    "NvimTree",
    "nvdash",
    "nvcheatsheet",
    "terminal",
    "Trouble",
    "help",
  },
}

M.plugins = "custom.plugins"
M.mappings = require "custom.mappings"
return M
