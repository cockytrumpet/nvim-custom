vim.keymap.set("n", "<leader>zZ", function()
  require("zen-mode").setup {
    window = {
      width = 90,
      options = {},
    },
  }
  require("zen-mode").toggle()
  vim.wo.wrap = true
  vim.wo.number = true
  vim.wo.rnu = true
end)

vim.keymap.set("n", "<leader>zz", function()
  require("zen-mode").setup {
    window = {
      backdrop = 0.93,
      width = 100,
      height = 1,
    },
    plugins = {
      options = {
        showcmd = true,
      },
      -- twilight = { enabled = false },
      gitsigns = { enabled = true },
    },
  }
  require("zen-mode").toggle()
end)
