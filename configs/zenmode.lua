vim.keymap.set("n", "<leader>zZ", function()
	require("zen-mode").setup({
		window = {
			width = 90,
			options = {},
		},
	})
	require("zen-mode").toggle()
	vim.wo.wrap = false
	vim.wo.number = true
	vim.wo.rnu = true
end)

vim.keymap.set("n", "<leader>zz", function()
	require("zen-mode").setup({
		window = {
			backdrop = 0.93,
			width = 150,
			height = 1,
		},
		plugins = {
			options = {
				showcmd = true,
			},
			twilight = { enabled = false },
			gitsigns = { enabled = true },
		},
	})
	require("zen-mode").toggle()
end)
