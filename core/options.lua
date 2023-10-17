local options = {
  backup = false, -- creates a backup file
  -- conceallevel = 0, -- so that `` is visible in markdown files
  fileencoding = "utf-8", -- the encoding written to a file
  hidden = true, -- required to keep multiple buffers and open multiple buffers
  ignorecase = true, -- ignore case in search patterns
  mouse = "a", -- allow the mouse to be used in neovim
  -- pumheight = 8, -- pop up menu height
  pumblend = 20, -- transparency of pop-up menu
  -- showmode = false, -- we don't need to see things like -- INSERT -- anymore
  smartcase = true, -- smart case
  smartindent = true, -- make indenting smarter again
  splitbelow = true, -- force all horizontal splits to go below current window
  splitright = true, -- force all vertical splits to go to the right of current window
  swapfile = false, -- creates a swapfile
  -- timeoutlen = 500, -- time to wait for a mapped sequence to complete (in milliseconds)
  undofile = true, -- enable persistent undo
  undodir = os.getenv "HOME" .. "/.undodir", -- set an undo directory
  updatetime = 50, -- faster completion (4000ms default)
  writebackup = false, -- if a file is being edited by another program (or was written to file while editing with another program), it is not allowed to be edited
  expandtab = true, -- convert tabs to spaces
  shiftwidth = 2, -- the number of spaces inserted for each indentation
  tabstop = 2, -- insert 2 spaces for a tab
  cursorline = true, -- highlight the current line
  number = true, -- set numbered lines
  relativenumber = true, -- set relative numbered lines
  numberwidth = 4, -- set number column width to 4 {default 4}
  signcolumn = "yes", -- always show the sign column, otherwise it would shift the text each time
  wrap = false, -- display lines as one long line
  scrolloff = 8, -- minimal number of columns to scroll horizontally.
  sidescrolloff = 8, -- minimal number of screen columns
  lazyredraw = false, -- Won't be redrawn while executing macros, register and other commands.
  termguicolors = true, -- Enables 24-bit RGB color in the TUI
  foldmethod = "expr",
  foldexpr = "nvim_treesitter#foldexpr()",
  foldenable = false,
  foldlevel = 99,
  foldlevelstart = 99,
  fillchars = { eob = " ", fold = " ", foldopen = "", foldsep = " ", foldclose = "", lastline = " " }, -- make EndOfBuffer invisible
  foldcolumn = "0",
  ruler = false,
  textwidth = 80,
  sessionoptions = "buffers,curdir,folds,globals,tabpages,winpos,winsize",
}

local global = {
  mkdp_auto_close = false, -- Don't Exit Preview When Switching Buffers
  mapleader = " ", -- Set mapleader to space
  -- python_recommended_style = 0, -- Disable python indentation
}

vim.cmd "au TextYankPost * silent! lua vim.highlight.on_yank()"
vim.cmd "set rtp+=/opt/homebrew/opt/fzf"
vim.opt.shortmess:append "Ac" -- Disable asking when editing file with swapfile.
vim.opt.whichwrap:append "<,>,[,],h,l"
vim.opt.iskeyword:append "-"

vim.keymap.set("n", "<Space>", "<Nop>", { silent = true, remap = false })

if vim.fn.executable "rg" then
  vim.opt.grepprg = "rg --vimgrep"
  vim.opt.grepformat = "%f:%l:%c:%m"
end

for name, value in pairs(options) do
  vim.opt[name] = value
end

for name, value in pairs(global) do
  vim.g[name] = value
end
