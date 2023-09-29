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
        ["af"] = { query = "@function.outer", desc = "ts: all function" },
        ["if"] = { query = "@function.inner", desc = "ts: inner function" },
        ["ac"] = { query = "@class.outer", desc = "ts: all class" },
        ["ic"] = { query = "@class.inner", desc = "ts: inner class" },
        ["aC"] = { query = "@conditional.outer", desc = "ts: all conditional" },
        ["iC"] = { query = "@conditional.inner", desc = "ts: inner conditional" },
        ["aH"] = { query = "@assignment.lhs", desc = "ts: assignment lhs" },
        ["aL"] = { query = "@assignment.rhs", desc = "ts: assignment rhs" },
      },
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
    "ruff",
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
    "file_browser"
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
