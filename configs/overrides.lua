local M = {}

M.treesitter = {
  ensure_installed = {
    "vim",
    "lua",
    "html",
    "css",
    "javascript",
    "typescript",
    "tsx",
    "c",
    "markdown",
    "markdown_inline",
    "vimdoc",
    "python",
    "query",
    "scala",
    "json",
    "yaml",
    "dockerfile",
    "diff",
    "sql",
    "bash",
  },
  sync_install = false,
  auto_install = true,
  ignore_install = {},
  indent = {
    enable = true,
    -- disable = {
    --   "python"
    -- },
  },
  highlight = {
    enable = true,
    additional_vim_regex_highlighting = false,
  },
  textsubjects = {
    enable = true,
    keymaps = {
      ["."] = "textsubjects-smart",
      [";"] = "textsubjects-container-outer",
      ["i;"] = "textsubjects-container-inner",
    },
  },
  textobjects = {
    select = {
      enable = true,
      lookahead = true,
      include_surrounding_whitespace = true,
      keymaps = {
        ["af"] = { query = "@function.outer", desc = "ts: around function" },
        ["if"] = { query = "@function.inner", desc = "ts: inner function" },
        ["aF"] = { query = "@call.outer", desc = "Select outer part of a function call" },
        ["iF"] = { query = "@call.inner", desc = "Select inner part of a function call" },

        ["ac"] = { query = "@class.outer", desc = "ts: around class" },
        ["ic"] = { query = "@class.inner", desc = "ts: inner class" },

        ["aC"] = { query = "@conditional.outer", desc = "ts: around conditional" },
        ["iC"] = { query = "@conditional.inner", desc = "ts: inner conditional" },

        ["aH"] = { query = "@assignment.lhs", desc = "ts: assignment lhs" },
        ["aL"] = { query = "@assignment.rhs", desc = "ts: assignment rhs" },

        ["ap"] = { query = "@parameter.outer", desc = "ts: outer parameter/argument" },
        ["ip"] = { query = "@parameter.inner", desc = "ts: inner parameter/argument" },

        ["al"] = { query = "@loop.outer", desc = "ts: outer loop" },
        ["il"] = { query = "@loop.inner", desc = "ts: inner loop" },
      },
    },
  },
  swap = {
    enable = true,
    swap_next = {
      ["<leader>np"] = "@parameter.inner", -- swap parameters/argument with next
      ["<leader>nf"] = "@function.outer", -- swap function with next
    },
    swap_previous = {
      ["<leader>pp"] = "@parameter.inner", -- swap parameters/argument with prev
      ["<leader>pf"] = "@function.outer", -- swap function with previous
    },
  },
  move = {
    enable = true,
    set_jumps = true, -- whether to set jumps in the jumplist
    goto_next_start = {
      ["]f"] = { query = "@call.outer", desc = "Next function call start" },
      ["]m"] = { query = "@function.outer", desc = "Next method/function def start" },
      ["]c"] = { query = "@class.outer", desc = "Next class start" },
      ["]i"] = { query = "@conditional.outer", desc = "Next conditional start" },
      ["]l"] = { query = "@loop.outer", desc = "Next loop start" },

      -- You can pass a query group to use query from `queries/<lang>/<query_group>.scm file in your runtime path.
      -- Below example nvim-treesitter's `locals.scm` and `folds.scm`. They also provide highlights.scm and indent.scm.
      ["]s"] = { query = "@scope", query_group = "locals", desc = "Next scope" },
      ["]z"] = { query = "@fold", query_group = "folds", desc = "Next fold" },
    },
    goto_next_end = {
      ["]F"] = { query = "@call.outer", desc = "Next function call end" },
      ["]M"] = { query = "@function.outer", desc = "Next method/function def end" },
      ["]C"] = { query = "@class.outer", desc = "Next class end" },
      ["]I"] = { query = "@conditional.outer", desc = "Next conditional end" },
      ["]L"] = { query = "@loop.outer", desc = "Next loop end" },
    },
    goto_previous_start = {
      ["[f"] = { query = "@call.outer", desc = "Prev function call start" },
      ["[m"] = { query = "@function.outer", desc = "Prev method/function def start" },
      ["[c"] = { query = "@class.outer", desc = "Prev class start" },
      ["[i"] = { query = "@conditional.outer", desc = "Prev conditional start" },
      ["[l"] = { query = "@loop.outer", desc = "Prev loop start" },
    },
    goto_previous_end = {
      ["[F"] = { query = "@call.outer", desc = "Prev function call end" },
      ["[M"] = { query = "@function.outer", desc = "Prev method/function def end" },
      ["[C"] = { query = "@class.outer", desc = "Prev class end" },
      ["[I"] = { query = "@conditional.outer", desc = "Prev conditional end" },
      ["[L"] = { query = "@loop.outer", desc = "Prev loop end" },
    },
  },

  tree_setter = {
    enable = true,
  },
  rainbow = {
    enable = true,
    extended_mode = false,
    max_file_lines = 1000,
    query = {
      "rainbow-parens",
      html = "rainbow-tags",
      javascript = "rainbow-tags-react",
      tsx = "rainbow-tags",
    },
  },
  context_commentstring = {
    enable = true,
    enable_autocmd = false,
  },
}

M.mason = {
  ensure_installed = {
    -- lua stuff
    "lua-language-server",
    "stylua",

    -- web dev stuff
    "css-lsp",
    "html-lsp",
    "typescript-language-server",
    "deno",
    "prettier",

    -- c/cpp stuff
    "clangd",
    "clang-format",
    "codelldb",

    -- Python
    "pyright",
    "ruff-lsp",
    "black",
    "debugpy",
    "isort",

    -- Json
    "jsonlint",
    "json-lsp",

    "dockerfile-language-server",
    "yaml-language-server",
  },
}

-- git support in nvimtree
M.nvimtree = {
  git = {
    enable = true,
  },

  renderer = {
    highlight_git = true,
    icons = {
      show = {
        git = true,
      },
    },
  },
  view = {
    side = "left",
  },
  hijack_unnamed_buffer_when_opening = true,
  hijack_cursor = true,
  sync_root_with_cwd = true,
  tab = {
    sync = {
      open = true,
      close = true,
    },
  },
}

M.telescope = {
  defaults = {
    file_ignore_patterns = {
      "node_modules",
      ".docker",
      ".git",
      "yarn.lock",
      "go.sum",
      "go.mod",
      "tags",
      "mocks",
      "refactoring",
    },
    layout_config = {
      horizontal = {
        prompt_position = "bottom",
      },
    },
  },
  extensions_list = {
    "themes",
    "terms",
    "notify",
    "frecency",
    "undo",
    "vim_bookmarks",
    "ast_grep",
    "ctags_plus",
    "luasnip",
    "lazygit",
    "fzf",
    "file_browser",
  },
  extensions = {
    fzf = {
      fuzzy = true,
      override_generic_sorter = true,
      override_file_sorter = true,
      case_mode = "smart_case",
    },
    ast_grep = {
      command = {
        "sg",
        "--json=stream",
        "-p",
      },
      grep_open_files = false,
      lang = nil,
    },
    lazy = {
      show_icon = true,
      mappings = {
        open_in_browser = "<C-o>",
        open_in_file_browser = "<M-b>",
        open_in_find_files = "<C-f>",
        open_in_live_grep = "<C-g>",
        open_plugins_picker = "<C-b>",
        open_lazy_root_find_files = "<C-r>f",
        open_lazy_root_live_grep = "<C-r>g",
      },
    },
    file_browser = {
      hijack_netrw = true,
      --[[ hidden = true,
      follow = true,
      width = 0.25,
      height = 0.5,
      disable_devicons = false,
      icons = {
        up = "",
        down = "",
        parent = "",
        folder = "",
        folder_open = "",
      }, ]]
    },
  },
}

return M
