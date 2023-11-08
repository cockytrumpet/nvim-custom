---@type ChadrcConfig
local M = {}

-- Path to overriding theme and highlights files
local highlights = require "custom.highlights"

M.ui = {
  statusline = {
    theme = "vscode_colored", -- default/vscode/vscode_colored/minimal
    -- default/round/block/arrow (separators work only for "default" statusline theme;
    -- round and block will work for the minimal theme only)
    separator_style = "block",
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
    style = "default", -- default/flat_light/flat_dark/atom/atom_colored
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

M.lazy_nvim = require "custom.configs.lazy_nvim"
M.plugins = "custom.plugins"
M.mappings = require "custom.mappings"
return M
