local present, copilot = pcall(require, "copilot")

if not present then
	return
end

copilot.setup()

vim.api.nvim_set_hl(0, "CopilotSuggestion", { fg = "#83a598" })
vim.api.nvim_set_hl(0, "CopilotAnnotation", { fg = "#03a598" })

-- require('copilot').setup({
-- DEFAULTS
-- panel = {
--   enabled = true,
--   auto_refresh = false,
--   keymap = {
--     jump_prev = "[[",
--     jump_next = "]]",
--     accept = "<CR>",
--     refresh = "gr",
--     open = "<M-CR>"
--   },
--   layout = {
--     position = "bottom", -- | top | left | right
--     ratio = 0.4
--   },
-- },
-- suggestion = {
--   enabled = true,
--   auto_trigger = false,
--   debounce = 75,
--   keymap = {
--     accept = "<M-l>",
--     accept_word = false,
--     accept_line = false,
--     next = "<M-]>",
--     prev = "<M-[>",
--     dismiss = "<C-]>",
--   },
-- },
-- filetypes = {
--   yaml = false,
--   markdown = false,
--   help = false,
--   gitcommit = false,
--   gitrebase = false,
--   hgcommit = false,
--   svn = false,
--   cvs = false,
--   ["."] = false,
-- },
-- copilot_node_command = 'node', -- Node.js version must be > 16.x
--   server_opts_overrides = {},
-- })
