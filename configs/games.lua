local popup = require "plenary.popup"

local Win_id

function ShowMenu(opts, cb)
  local height = 20
  local width = 30
  local borderchars = { "─", "│", "─", "│", "╭", "╮", "╯", "╰" }

  Win_id = popup.create(opts, {
    title = "Games",
    highlight = "PopupColor",
    line = math.floor(((vim.o.lines - height) / 2) - 1),
    col = math.floor((vim.o.columns - width) / 2),
    minwidth = width,
    minheight = height,
    borderchars = borderchars,
    callback = cb,
    modifiable = false,
  })
  local bufnr = vim.api.nvim_win_get_buf(Win_id)
  vim.api.nvim_buf_set_option(bufnr, "modifiable", false)
  vim.api.nvim_buf_set_keymap(bufnr, "n", "q", "<cmd>lua CloseMenu()<CR>", { silent = false })
end

function CloseMenu()
  vim.api.nvim_win_close(Win_id, true)
end

function GamesMenu()
  local opts = { "VimBeGood" }
  local cb = function(_, sel)
    vim.cmd(sel)
  end
  ShowMenu(opts, cb)
end
