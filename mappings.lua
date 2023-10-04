local M = {}

M.general = {
  i = {
    ["<C-Up>"] = { "<CMD>m .-2<CR>==", "󰜸 Move line up" },
    ["<C-Down>"] = { "<CMD>m .+1<CR>==", "󰜯 Move line down" },
  },

  v = {
    ["<leader>fm"] = {
      function()
        require("conform").format {
          lsp_fallback = true,
          async = false,
          timeout_ms = 4000,
        }
      end,
      "Format file or range (in visual mode)",
    },
  },

  n = {
    ["gX"] = {
      function()
        local word = vim.fn.expand "<cfile>"
        local url = "https://github.com/" .. word
        vim.ui.open(url)
      end,
      "󰙍 Open github repo",
    },
    ["<leader>fm"] = {
      function()
        require("conform").format {
          lsp_fallback = true,
          async = false,
          -- timeout_ms = 500,
        }
      end,
      "Format file or range (in visual mode)",
    },
    ["<leader>sk"] = { "<CMD>put!=repeat(nr2char(10), v:count1)<CR>", "Add line above" },
    ["<leader>sj"] = { "<CMD>put=repeat(nr2char(10), v:count1)<CR>", "Add line below" },
    ["<Esc>"] = {
      function()
        vim.cmd "noh"
        vim.cmd "Noice dismiss"
      end,
      " Clear highlights",
      opts = { silent = true },
    },
    ["<leader>sp"] = {
      function()
        require("treesj").toggle()
      end,
      "󱓡 Toggle split/join",
    },
    [";"] = { ":", "enter command mode", opts = { nowait = true } },
    ["<C-Up>"] = { "<CMD>m .-2<CR>==", "󰜸 Move line up" },
    ["<C-Down>"] = { "<CMD>m .+1<CR>==", "󰜯 Move line down" },
    ["<A-d>"] = { "<CMD>MCstart<CR>", "Multi cursor" },
    ["<C-h>"] = { "<cmd> TmuxNavigateLeft<CR>", "window left" },
    ["<C-l>"] = { "<cmd> TmuxNavigateRight<CR>", "window right" },
    ["<C-j>"] = { "<cmd> TmuxNavigateDown<CR>", "window down" },
    ["<C-k>"] = { "<cmd> TmuxNavigateUp<CR>", "window up" },
    ["<leader>T"] = { "<cmd> TestOnSave<CR>", "pytest" },
    ["<leader>K"] = { "<cmd> TestLineDiag <CR>", "pytest line diagnostics" },
    ["<leader>rf"] = {
      function()
        run_code()
      end,
      "run file",
    },
    --[[
    ["<leader>rfi"] = {
      function()
        local directory = vim.fn.expand "%:p:h"
        local file = vim.fn.expand "%:t"
        local file_base = vim.fn.expand "%:t:r"
        local ft_cmds = {
          scala = string.format("cd %s && scala-cli %s", directory, file),
          python = string.format("cd %s && python %s", directory, file),
          c = string.format("cd %s && gcc %s -o %s && ./%s", directory, file, file_base, file_base),
          cpp = string.format("cd %s && g++ %s -o %s && ./%s", directory, file, file_base, file_base),
          make = string.format("cd %s && make clean && make run", directory),
        }
        if file_exists "Makefile" then
          require("nvterm.terminal").send(ft_cmds["make"], "float")
        else
          require("nvterm.terminal").send(ft_cmds[vim.bo.filetype], "float")
        end
      end,
      "run file",
    },
]]
  },
}
--[[
M.terminal = {
  n = {
    -- spawn new terms
    ["<leader>h"] = {
      function()
        require("nvchad.term").new { pos = "sp", size = 0.3 }
      end,
      "New horizontal term",
    },

    ["<leader>v"] = {
      function()
        require("nvchad.term").new { pos = "vsp", size = 0.3 }
      end,
      "New vertical term",
    },

    -- toggle terms
    ["<A-v>"] = {
      function()
        require("nvchad.term").toggle { pos = "vsp", id = "vtoggleTerm", size = 0.3 }
      end,
      "New vertical term",
    },

    ["<A-l>"] = {
      function()
        require("nvchad.term").toggle { pos = "sp", id = "htoggleTerm", size = 0.2 }
      end,
      "New vertical term",
    },

    ["<A-j>"] = {
      function()
        require("nvchad.term").toggle { pos = "float", id = "floatTerm" }
      end,
      "Toggleable Floating term",
    },
  },

  -- toggle terms in terminal mode
  t = {
    ["<ESC>"] = {
      function()
        local win = vim.api.nvim_get_current_win()
        vim.api.nvim_win_close(win, true)
      end,
      "close term in terminal mode",
    },

    ["<A-l>"] = {
      function()
        require("nvchad.term").toggle { pos = "vsp", id = "vtoggleTerm" }
      end,
      "New vertical term",
    },

    ["<A-j>"] = {
      function()
        require("nvchad.term").toggle { pos = "sp", id = "htoggleTerm" }
      end,
      "New vertical term",
    },

    ["<A-i>"] = {
      function()
        require("nvchad.term").toggle { pos = "float", id = "floatTerm" }
      end,
      "Toggleable Floating term",
    },
  },
}
]]

M.test = {
  n = {
    ["<leader>nt"] = {
      function()
        require("neotest").summary.toggle()
      end,
      "󰤑 Run neotest",
    },
  },
}

M.codewindow = {
  n = {
    ["<leader>MM"] = {
      function()
        require("codewindow").open_minimap()
      end,
      "Open Minimap",
    },
    ["<leader>MT"] = {
      function()
        require("codewindow").toggle_minimap()
      end,
      "Toggle Minimap",
    },
  },
}

M.dap = {
  plugin = true,
  n = {
    ["<leader>db"] = {
      "<cmd> DapToggleBreakpoint <CR>",
      "Add breakpoint at line",
    },
    ["<leader>dB"] = {
      ":lua require'dap'.set_breakpoint(vim.fn.input('Breakpoint condition: '))<cr>",
      "Breakpoint Condition",
      opts = { silent = true },
    },
    ["<leader>dr"] = {
      "<cmd> DapUIRestart <CR>",
      "Restart the debugger",
    },
    ["<leader>dd"] = {
      "<cmd> DapUIToggle <CR>",
      "Toggle DAP UI",
    },
    ["<F5>"] = {
      "<cmd> lua require'dap'.continue() <CR>",
      "Add breakpoint at line",
    },
    ["<F10>"] = {
      "<cmd> lua require'dap'.step_over() <CR>",
      "Add breakpoint at line",
    },
    ["<F11>"] = {
      "<cmd> lua require'dap'.step_into() <CR>",
      "Add breakpoint at line",
    },
    ["<F12>"] = {
      "<cmd> lua require'dap'.step_out() <CR>",
      "Add breakpoint at line",
    },
  },
}

M.dap_python = {
  plugin = true,
  n = {
    ["<leader>dpr"] = {
      function()
        require("dap-python").test_method()
      end,
      "Run python tests",
    },
  },
}

M.undotree = {
  plugin = true,
  n = {
    ["<leader>u"] = {
      "<cmd> UndotreeToggle <CR>",
      "UndoTree",
    },
  },
}

M.trouble = {
  plugin = true,
  n = {
    ["<leader>tr"] = {
      "<cmd>TroubleToggle quickfix<cr>",
      "Trouble: quickfix",
    },
    ["<leader>tw"] = { "<CMD>TroubleToggle<CR>", "󰔫 Toggle warnings" },
    ["<leader>td"] = { "<CMD>TodoTrouble keywords=TODO,FIX,FIXME,BUG,TEST,NOTE<CR>", " Todo/Fix/Fixme" },
    ["<leader>ft"] = { "<CMD>TodoTelescope<CR>", " Telescope TODO" },
  },
}

M.telescope = {
  n = {
    ["<leader>tt"] = {
      function()
        require("base46").toggle_transparency()
      end,
      "toggle transparency",
    },
    ["<leader>ff"] = { "<cmd> Telescope find_files follow=true<CR>", "Find files" },
    ["<leader>fi"] = { "<CMD>Telescope highlights<CR>", "Highlights" },
    ["<leader>fk"] = { "<CMD>Telescope keymaps<CR>", " Find keymaps" },
    ["<leader>fs"] = { "<CMD>Telescope lsp_document_symbols<CR>", " Find document symbols" },
    ["<leader>fr"] = { "<CMD>Telescope frecency<CR>", " Recent files" },
    ["<leader>fu"] = { "<CMD>Telescope undo<CR>", " Undo tree" },
    ["<leader>fa"] = { ":Telescope autocommands<cr>", "Autocommmands", opts = { silent = true } },
    ["<leader>fM"] = { ":Telescope marks<cr>", "Marks", opts = { silent = true } },
    ["<leader>fw"] = { ":Telescope live_grep<cr>", "Word", opts = { silent = true } },
    ["<leader>ft"] = { ":Telescope themes<cr>", "Themes", opts = { silent = true } },
    -- ["<leader>fT"] = { ":TodoTelescope<cr>", "Todo", opts = { silent = true } },
    -- B = { ":Telescope bookmarks<cr>", "Browswer Bookmarks" , opts = { silent = true }},
    ["<leader>fb"] = { ":Telescope buffers<cr>", "Buffers", opts = { silent = true } },
    ["<leader>fn"] = {
      ":lua require('telescope').extensions.notify.notify()<cr>",
      "Notify History",
      opts = { silent = true },
    },
    -- ["<leader>fp"] = { ":Telescope projects<cr>", "Projects", opts = { silent = true } },
    -- s = { ":Telescope persisted<cr>", "Sessions" , opts = { silent = true }},
    ["<leader>fh"] = { ":Telescope help_tags<cr>", "Help", opts = { silent = true } },
    ["<leader>fC"] = { ":Telescope commands<cr>", "Commands", opts = { silent = true } },
    ["<leader>fH"] = { ":Telescope highlights<cr>", "Highlights", opts = { silent = true } },
    ["<leader>fd"] = { ":Telescope diagnostics bufnr=0<cr>", "Document Diagnostics", opts = { silent = true } },
    ["<leader>fD"] = { ":Telescope diagnostics<cr>", "Workspace Diagnostics", opts = { silent = true } },
  },
}

M.harpoon = {
  n = {
    ["<leader>ha"] = {
      function()
        require("harpoon.mark").add_file()
      end,
      "󱡁 Harpoon Add file",
    },
    ["<leader>ht"] = { "<CMD>Telescope harpoon marks<CR>", "󱡀 Toggle quick menu" },
    ["<leader>hb"] = {
      function()
        require("harpoon.ui").toggle_quick_menu()
      end,
      "󱠿 Harpoon Menu",
    },
    ["<leader>1"] = {
      function()
        require("harpoon.ui").nav_file(1)
      end,
      "󱪼 Navigate to file 1",
    },
    ["<leader>2"] = {
      function()
        require("harpoon.ui").nav_file(2)
      end,
      "󱪽 Navigate to file 2",
    },
    ["<leader>3"] = {
      function()
        require("harpoon.ui").nav_file(3)
      end,
      "󱪾 Navigate to file 3",
    },
    ["<leader>4"] = {
      function()
        require("harpoon.ui").nav_file(4)
      end,
      "󱪿 Navigate to file 4",
    },
  },
}

M.persisted = {
  n = {
    ["<leader>ss"] = { "<CMD>Telescope persisted<CR>", "󰆓 List session" },
    ["<leader>sd"] = { "<CMD>SessionDelete<CR>", "󱙃 Delete Session" },
  },
}

M.ufo = {
  plugin = true,
  n = {
    ["zR"] = {
      function()
        require("ufo").openAllFolds()
      end,
      "Open all folds",
    },
    ["zM"] = {
      function()
        require("ufo").closeAllFolds()
      end,
      "Close all folds",
    },
    ["zr"] = {
      function()
        require("ufo").openFoldsExceptKinds()
      end,
      "Open all folds except kinds",
    },
    ["zm"] = {
      function()
        require("ufo").closeFoldsWith()
      end,
      "Close all folds with",
    },
    ["K"] = {
      function()
        local winid = require("ufo").peekFoldedLinesUnderCursor()
        if not winid then
          vim.lsp.buf.hover()
        end
      end,
      "Peek definition",
    },
  },
}

return M
