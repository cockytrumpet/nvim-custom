-- To find any highlight groups: "<cmd> Telescope highlights"
-- Each highlight group can take a table with variables fg, bg, bold, italic, etc
-- base30 variable names can also be used as colors

local M = {}

---@type Base46HLGroupsList
M.override = {
  Comment = {
    italic = true,
  },
}

---@type HLTable
M.add = {
  FoldColumn = {
    fg = "grey",
    bg = "black",
    bold = true,
    sp = "NONE",
  },
  VirtColumn = {
    fg = "lightbg",
  },
  StCcIcon = {
    fg = "black",
    bg = "pink",
  },
  StCcText = {
    fg = "pink",
    bg = "#262a2f",
  },
  NeogitDiffDeleteHighlight = {
    fg = "red",
    bg = "#3d1212",
  },
  NeogitDiffDelete = {
    fg = "#B13B5C",
    bg = "#3d1212",
  },
  NeogitDiffAddHighlight = {
    fg = "green",
    bg = "#1e4620",
  },
  NeogitDiffAdd = {
    fg = "#3FB950",
    bg = "#1e4620",
  },
  NvimTreeOpenedFile = {
    fg = "orange",
  },
}

return M
