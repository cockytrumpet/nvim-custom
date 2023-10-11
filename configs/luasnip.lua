local present, luasnip = pcall(require, "luasnip")

if not present then
  return
end

luasnip.filetype_extend("javascriptreact", { "html" })
luasnip.filetype_extend("vue", { "html" })

require("luasnip/loaders/from_vscode").lazy_load()
require("luasnip.loaders.from_lua").load { paths = "~/.config/nvim/lua/custom/luasnip" }

local types = require "luasnip.util.types"

vim.cmd [[command! LuaSnipEdit :lua require("luasnip.loaders.from_lua").edit_snippet_files()]]
vim.cmd [[autocmd BufEnter */luasnip/*.lua nnoremap <silent> <buffer> <CR> /-- End Snippets --<CR>O<Esc>O]]

luasnip.setup {
  history = true, --keep around last snippet local to jump back
  updateevents = "TextChanged,TextChangedI", --update changes as you type
  enable_autosnippets = true,
  ext_opts = {
    [types.insertNode] = {
      unvisited = {
        virt_text = { { "|", "Conceal" } },
        -- virt_text_pos = "inline",
      },
      active = {
        virt_text = { { "󰩫", "yellow" } },
      },
    },
    [types.exitNode] = {
      unvisited = {
        virt_text = { { "|", "Conceal" } },
        -- virt_text_pos = "inline",
      },
    },
    [types.choiceNode] = {
      active = {
        virt_text = { { "", "blue" } },
      },
    },
  },
}
