local autocmd = vim.api.nvim_create_autocmd
local augroup = vim.api.nvim_create_augroup
local settings = require("custom.chadrc").settings

-- General Settings
local general = augroup("General Settings", { clear = true })

local persisted_group = vim.api.nvim_create_augroup("PersistedHooks", {})

-- Don't let some things get persisted
vim.api.nvim_create_autocmd({ "User" }, {
  pattern = "PersistedSavePre",
  group = persisted_group,
  callback = function()
    local filetypes_to_close = { "minimap", "NvimTree*", "Trouble", "Outline" }
    for _, filetype in ipairs(filetypes_to_close) do
      local cmd = "bw " .. filetype
      pcall(vim.cmd, cmd)
    end
  end,
})

vim.api.nvim_create_autocmd({ "User" }, {
  pattern = "PersistedLoadPost",
  group = persisted_group,
  callback = function()
    vim.schedule(function()
      local api = require "nvim-tree.api"
      api.tree.toggle { find_file = true, focus = false }
    end)
  end,
})

vim.api.nvim_create_autocmd({ "User" }, {
  pattern = "PersistedTelescopeLoadPre",
  group = persisted_group,
  callback = function()
    vim.api.nvim_input "<ESC>:%bd!<CR>"
  end,
})

-- disable folds in these filetypes
vim.api.nvim_create_autocmd("FileType", {
  pattern = {
    "neotest-summary",
    "Neogit*",
    "terminal",
  },
  callback = function()
    require("ufo").detach()
    vim.opt_local.foldenable = false
  end,
})

-- Auto resize panes when resizing nvim window
autocmd("VimResized", {
  pattern = "*",
  command = "tabdo wincmd =",
})

-- Fix semantic tokens for lsp
-- autocmd("LspAttach", {
--   callback = function(args)
--     local client = vim.lsp.get_client_by_id(args.data.client_id)
--     client.server_capabilities.semanticTokensProvider = nil
--   end,
-- })

-- Fix NvimTree not opening on startup when using session restore plugin
-- autocmd({ "BufEnter" }, {
--   pattern = "NvimTree*",
--   callback = function()
--     local api = require "nvim-tree.api"
--     local view = require "nvim-tree.view"
--     if not view.is_visible() then
--       api.tree.open()
--     end
--   end,
-- })

-- Close Nvimtree before quit nvim
-- autocmd("FileType", {
--   pattern = { "NvimTree*" },
--   callback = function(args)
--     autocmd("VimLeavePre", {
--       callback = function()
--         vim.api.nvim_buf_delete(args.buf, { force = true })
--         return true
--       end,
--     })
--   end,
-- })

-- Nvimtree open file on creation
autocmd({ "VimEnter" }, {
  callback = function()
    require("nvim-tree.api").events.subscribe("FileCreated", function(file)
      vim.cmd("edit " .. file.fname)
    end)
  end,
})

-- Open new buffer if only Nvimtree is open
autocmd("BufEnter", {
  nested = true,
  callback = function()
    local api = require "nvim-tree.api"
    if #vim.api.nvim_list_wins() == 1 and api.tree.is_tree_buf() then
      vim.defer_fn(function()
        api.tree.toggle { find_file = true, focus = true }
        vim.cmd "wincmd p"
      end, 0)
    end
  end,
})

-- Open NvimTree on startup
-- autocmd("VimEnter", {
--   callback = function()
--     local api = require "nvim-tree.api"
--     local view = require "nvim-tree.view"
--     if not view.is_visible() then
--       api.tree.toggle { find_file = true, focus = false }
--       -- require("nvim-tree.api").tree.open()
--     end
--   end,
-- })

-- Close nvim if NvimTree is only running buffer
-- autocmd("BufEnter", {
--   command = [[if winnr('$') == 1 && bufname() == 'NvimTree_' . tabpagenr() | quit | endif]],
-- })
--[[
-- Close NvimTree if in Neogit
autocmd({ "BufEnter" }, {
  pattern = "Neogit*",
  callback = function()
    local api = require "nvim-tree.api"
    local view = require "nvim-tree.view"
    if view.is_visible() then
      vim.g.reopen_nvimtree = true
      api.tree.close()
    end
  end,
})

-- Reopen NvimTree if it was open before Neogit
autocmd({ "TabClosed" }, {
  callback = function()
    if vim.g.reopen_nvimtree then
      local ft = {
        "NeogitStatus",
        "NeogitLog",
        "NeogitCommit",
        "NeogitConfig",
        "NeogitBlame",
        "NeogitCommitView",
        "NeogitCommitPopup",
        "NeogitPopup",
      }
      if vim.tbl_contains(ft, vim.g.filetype) then
        return
      end
      vim.g.reopen_nvimtree = nil
      local api = require "nvim-tree.api"
      local view = require "nvim-tree.view"
      if not view.is_visible() then
        api.tree.toggle { find_file = true, focus = true }
      end
    end
  end,
})
]]
-- Prefetch tabnine
-- autocmd("BufRead", {
--   group = augroup("prefetch", { clear = true }),
--   pattern = "*",
--   callback = function()
--     require("cmp_tabnine"):prefetch(vim.fn.expand "%:p")
--   end,
-- })

-- Don't auto comment new line
autocmd("BufEnter", {
  command = [[set formatoptions-=cro]],
})
--[[
-- Go to last loc when opening a buffer
autocmd("BufReadPost", {
  callback = function()
    local mark = vim.api.nvim_buf_get_mark(0, '"')
    local lcount = vim.api.nvim_buf_line_count(0)
    if mark[1] > 0 and mark[1] <= lcount then
      pcall(vim.api.nvim_win_set_cursor, 0, mark)
    end
  end,
})
]]
-- Git conflict popup
-- autocmd("User", {
--   pattern = "GitConflictDetected",
--   callback = function()
--     vim.notify("Conflict detected in " .. vim.fn.expand "<afile>")
--     vim.keymap.set("n", "cww", function()
--       engage.conflict_buster()
--       create_buffer_local_mappings()
--     end)
--   end,
-- })

-- Load git-conflict only when a git file is opened
-- autocmd({ "BufRead" }, {
--   group = vim.api.nvim_create_augroup("GitConflictLazyLoad", { clear = true }),
--   callback = function()
--     vim.fn.system("git -C " .. '"' .. vim.fn.expand "%:p:h" .. '"' .. " rev-parse")
--     if vim.v.shell_error == 0 then
--       vim.api.nvim_del_augroup_by_name "GitConflictLazyLoad"
--       vim.schedule(function()
--         require("lazy").load { plugins = { "git-conflict.nvim" } }
--       end)
--     end
--   end,
-- })

-- Disable status column in the following files
autocmd({ "BufEnter", "BufNew" }, {
  callback = function(ev)
    local ft_ignore = {
      "Outline",
      "man",
      "help",
      "neo-tree",
      "starter",
      "TelescopePrompt",
      "Trouble",
      "NvimTree",
      "NvimTree_1",
      "nvcheatsheet",
      "dapui_watches",
      "dap-repl",
      "dapui_console",
      "dapui_stacks",
      "dapui_breakpoints",
      "dapui_scopes",
      "themes",
      "terminal",
    }

    if vim.tbl_contains(ft_ignore, vim.bo.filetype) then
      vim.cmd "setlocal statuscolumn="
      vim.o.scrolloff = 0
    end
  end,
})

autocmd("FileType", {
  pattern = { "gitcommit", "markdown", "text", "log", "help" },
  callback = function()
    vim.opt_local.wrap = true
    vim.opt_local.spell = true
  end,
  group = general,
  desc = "Enable Wrap in these filetypes",
})

-- Highlight on yank
autocmd("TextYankPost", {
  command = "silent! lua vim.highlight.on_yank({higroup='YankVisual', timeout=500})",
  group = augroup("YankHighlight", { clear = true }),
})
--[[
-- Show cursor line only in active window
autocmd({ "InsertLeave", "WinEnter" }, {
  pattern = "*",
  command = "set cursorline",
  group = augroup("CursorLine", { clear = true }),
})
autocmd({ "InsertEnter", "WinLeave" }, {
  pattern = "*",
  command = "set nocursorline",
  group = augroup("CursorLine", { clear = true }),
})
]]
--- Remove all trailing whitespace on save
autocmd("BufWritePre", {
  command = [[:%s/\s\+$//e]],
  group = augroup("TrimWhiteSpaceGrp", { clear = true }),
})
--[[
-- Disable scrolloff in blacklisted filetypes
autocmd({ "BufEnter" }, {
  callback = function()
    vim.o.scrolloff = (vim.tbl_contains(settings.blacklist, vim.bo.ft) and 0 or settings.so_size)
  end,
})
]]
-- Restore cursor
autocmd({ "BufReadPost" }, {
  pattern = { "*" },
  callback = function()
    vim.cmd 'silent! normal! g`"zv'
  end,
})

-- Windows to close with "q"
autocmd("FileType", {
  pattern = {
    "help",
    "startuptime",
    "qf",
    "lspinfo",
    "man",
    "checkhealth",
    "tsplayground",
    "HIERARCHY-TREE-GO",
    "dap-float",
    "null-ls-info",
    "empty",
    "neotest-output",
    "neotest-summary",
    "neotest-output-panel",
    "fugitive",
    "Outline",

    -- "Neogit*",
  },
  command = [[
            nnoremap <buffer><silent> q :close<CR>
            set nobuflisted
        ]],
})

-- Disable diagnostics in node_modules (0 is current buffer only)
-- autocmd({ "BufRead", "BufNewFile" }, {
--   pattern = "*/node_modules/*",
--   command = "lua vim.diagnostic.disable(0)",
-- })

-- Go exclusive mappings
-- autocmd("FileType", {
--   callback = function()
--     if vim.bo.ft == "go" then
--       require("core.utils").load_mappings "go"
--     else
--       require("custom.utils.core").remove_mappings "go"
--     end
--   end,
-- })

-- start git messages in insert mode
vim.api.nvim_create_autocmd("FileType", {
  pattern = { "gitcommit", "gitrebase" },
  command = "startinsert | 1",
})

autocmd("TermOpen", {
  callback = function()
    vim.opt_local.relativenumber = false
    vim.opt_local.number = false
    vim.opt_local.signcolumn = "no"
    vim.opt_local.cursorline = false
    vim.opt_local.cursorcolumn = false
    vim.opt_local.scrolloff = 0
    vim.opt_local.sidescrolloff = 0
    vim.opt_local.foldenable = false
    vim.opt_local.foldcolumn = "0"
    vim.opt_local.list = false
    vim.opt_local.colorcolumn = ""
    vim.opt_local.spell = false
    vim.opt_local.spelllang = "en_us"
    vim.opt_local.conceallevel = 0
    vim.opt_local.concealcursor = ""
    vim.cmd "startinsert!"
  end,
  group = general,
  desc = "Terminal Options",
})

--[[
vim.api.nvim_create_autocmd("TermOpen", {
  callback = function()
    vim.cmd.set "filetype=term"
  end,
})
]]

-- Unlink the snippet and restore completion
-- https://github.com/L3MON4D3/LuaSnip/issues/258#issuecomment-1011938524
vim.api.nvim_create_autocmd("ModeChanged", {
  pattern = "*",
  callback = function()
    if
      ((vim.v.event.old_mode == "s" and vim.v.event.new_mode == "n") or vim.v.event.old_mode == "i")
      and require("luasnip").session.current_nodes[vim.api.nvim_get_current_buf()]
      and not require("luasnip").session.jump_active
    then
      require("luasnip").unlink_current()
      require("cmp.config").set_global {
        completion = { autocomplete = { require("cmp.types").cmp.TriggerEvent.TextChanged } },
      }
    end
  end,
})

-- Do not automatically trigger completion if we are in a snippet
vim.api.nvim_create_autocmd("User", {
  pattern = "LuaSnipInsertNodeEnter",
  callback = function()
    require("cmp.config").set_global { completion = { autocomplete = false } }
  end,
})

-- But restore it when we leave.
vim.api.nvim_create_autocmd("User", {
  pattern = "LuaSnipInsertNodeLeave",
  callback = function()
    require("cmp.config").set_global {
      completion = { autocomplete = { require("cmp.types").cmp.TriggerEvent.TextChanged } },
    }
  end,
})

-- Enable it when changing highlights
autocmd("BufWritePost", {
  pattern = "*.lua",
  callback = function()
    require("base46").load_all_highlights()
  end,
})

------------------ pytest TestOnSave ------------------

local cmd = {
  "pytest",
  "--json-report",
  "--json-report-file=/dev/stderr",
  "-q",
  "--no-header",
  "--no-summary",
}

local attach_to_buffer = function(bufnr, command)
  local group = vim.api.nvim_create_augroup("TestOnSave", { clear = true })
  local ns = vim.api.nvim_create_namespace "TestOnSave"

  local state = {
    bufnr = bufnr,
    tests = {},
    summary = {},
  }

  local add_test = function(entry)
    local message = ""
    if entry.call.longrepr then
      message = entry.call.longrepr
    end

    state.tests[entry.nodeid] = {
      outcome = entry.outcome,
      nodeid = entry.nodeid,
      test = entry.keywords[1],
      file = entry.keywords[2],
      line_number = entry.lineno,
      message = message,
    }
  end

  vim.api.nvim_create_user_command("TestLineDiag", function()
    local line = vim.fn.line "." - 1
    for _, test in pairs(state.tests) do
      if test.line_number == line then
        vim.notify(test.message, "error", {
          title = test.nodeid,
          on_open = function(win)
            local buf = vim.api.nvim_win_get_buf(win)
            vim.api.nvim_buf_set_option(buf, "filetype", "python")
          end,
        })
      end
    end
  end, {})

  vim.api.nvim_create_autocmd("BufWritePost", {
    group = group,
    pattern = "*.py",
    callback = function()
      vim.fn.jobstart(command, {
        stdout_buffered = true,
        stderr_buffered = true,
        on_stderr = function(_, data)
          if not data then
            return
          end

          local decoded = vim.fn.json_decode(data)
          if not decoded then
            return
          else
            state.summary = decoded.summary
          end

          local tests = decoded.tests
          if not tests then
            return
          end

          vim.api.nvim_buf_clear_namespace(bufnr, ns, 0, -1)

          for _, line in pairs(tests) do
            add_test(line)
            if state.tests[line.nodeid].outcome == "passed" then
              local text = { "✓", "DiagnosticOK" }
              vim.api.nvim_buf_set_extmark(bufnr, ns, state.tests[line.nodeid].line_number, 0, {
                virt_text = { text },
              })
            end
          end
        end,
        on_exit = function()
          local failed = {}
          for _, test in pairs(state.tests) do
            if test.outcome == "failed" then
              table.insert(failed, {
                bufnr = bufnr,
                lnum = test.line_number,
                col = 0,
                severity = vim.lsp.protocol.DiagnosticSeverity.Error,
                source = "pytest",
                message = "Test failed",
                user_data = {},
              })
            end
          end
          vim.diagnostic.set(ns, bufnr, failed, {})
          if state.summary.total == state.summary.passed then
            vim.notify("All tests passed", "info", {
              title = state.summary.total .. " tests completed",
            })
          else
            vim.notify("Passed: " .. state.summary.passed .. "\nFailed: " .. state.summary.failed, "warn", {
              title = state.summary.total .. " tests completed",
            })
          end
        end,
      })
    end,
  })
end

vim.api.nvim_create_user_command("TestOnSave", function()
  attach_to_buffer(vim.api.nvim_get_current_buf(), cmd)
end, {})
--------------------------- end ---------------------------
