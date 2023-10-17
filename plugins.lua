-- To make a plugin not be loaded
-- {
--   "NvChad/nvim-colorizer.lua",
--   enabled = false
-- },

-- All NvChad plugins are lazy-loaded by default
-- For a plugin to be loaded, you will need to set either `ft`, `cmd`, `keys`, `event`, or set `lazy = false`
-- If you want a plugin to load on startup, add `lazy = false` to a plugin spec, for example
-- {
--   "mg979/vim-visual-multi",
--   lazy = false,
-- }

local overrides = require "custom.configs.overrides"
local cmp_opt = require "custom.configs.cmp"

---@type NvPluginSpec[]
local plugins = {
  -- Override plugin definition options
  {
    "neovim/nvim-lspconfig",
    --[[ opts = {
      -- options for vim.diagnostic.config()
      diagnostics = {
        underline = false,
        update_in_insert = true,
        virtual_text = {
          spacing = 4,
          source = "if_many",
          -- prefix = "●",
          -- this will set set the prefix to a function that returns the diagnostics icon based on the severity
          -- this only works on a recent 0.10.0 build. Will be set to "●" when not supported
          prefix = "icons",
        },
        severity_sort = true,
      },
      -- Enable this to enable the builtin LSP inlay hints on Neovim >= 0.10.0
      -- Be aware that you also will need to properly configure your LSP server to
      -- provide the inlay hints.
      inlay_hints = {
        enabled = true,
      },
    }, ]]
    config = function()
      require "plugins.configs.lspconfig"
      require "custom.configs.lspconfig"
    end,
  },

  -- override plugin configs
  {
    "williamboman/mason.nvim",
    dependencies = {
      "WhoIsSethDaniel/mason-tool-installer.nvim",
    },
    config = function()
      local mason = require "mason"

      local mason_tool_installer = require "mason-tool-installer"

      -- enable mason and configure icons
      mason.setup {
        ui = {
          icons = {
            package_installed = "✓",
            package_pending = "➜",
            package_uninstalled = "✗",
          },
        },
      }

      mason_tool_installer.setup {
        ensure_installed = require("custom.configs.overrides").mason.ensure_installed,
      }
    end,
  },
  {
    "stevearc/conform.nvim",
    event = { "BufReadPre", "BufNewFile" },
    config = function()
      local conform = require "conform"

      conform.setup {
        formatters_by_ft = {
          javascript = { "prettier" },
          typescript = { "prettier" },
          javascriptreact = { "prettier" },
          typescriptreact = { "prettier" },
          svelte = { "prettier" },
          css = { "prettier" },
          html = { "prettier" },
          json = { "prettier" },
          yaml = { "prettier" },
          markdown = { "prettier" },
          graphql = { "prettier" },
          lua = { "stylua" },
          python = { "isort", "black" },
          cpp = { "clang-format" },
          c = { "clang-format" },
          ocaml = { "ocamlformat" },
          -- scala = { "scalafmt" },
        },
        format_on_save = {
          lsp_fallback = true,
          async = false,
          timeout_ms = 4000,
        },
      }

      --[[ require("conform.formatters.scalafmt").args = {
        "--stdin",
        "--stdout",
        "--non-interactive",
      } ]]
    end,
  },
  {
    "nvim-tree/nvim-tree.lua",
    dependencies = { "antosha417/nvim-lsp-file-operations" },
    opts = overrides.nvimtree,
  },
  -- Install plugins
  {
    "uga-rosa/ccc.nvim",
    cmd = "CccPick",
    config = function()
      require("ccc").setup {
        -- Your preferred settings
        -- Example: enable highlighter
        highlighter = {
          auto_enable = false,
          lsp = false,
        },
      }
    end,
  },
  { "onsails/lspkind.nvim" },
  { "folke/neodev.nvim", opts = {} },
  {
    "kevinhwang91/nvim-bqf",
    ft = "qf",
  },
  {
    "altermo/ultimate-autopair.nvim",
    event = { "InsertEnter", "CmdlineEnter" },
    branch = "v0.6", --recomended as each new version will have breaking changes
    opts = {
      --Config goes here
      tabout = {
        enable = true,
        hopout = true,
        tabkey = "<Tab>",
        backwards_tabkey = "<S-Tab>",
      },
    },
  },
  {
    "nvim-neorg/neorg",
    build = ":Neorg sync-parsers",
    dependencies = { "nvim-lua/plenary.nvim" },
    cmd = "Neorg",
    config = function()
      require("neorg").setup {
        load = {
          ["core.defaults"] = {},
          ["core.concealer"] = {},
          ["core.dirman"] = {
            config = {
              workspaces = {
                notes = "~/notes",
              },
              default_workspace = "notes",
            },
          },
        },
      }
      --[[
      vim.wo.foldlevel = 99
      vim.wo.conceallevel = 2
]]
    end,
  },
  {
    "hinell/lsp-timeout.nvim",
    dependencies = { "neovim/nvim-lspconfig" },
  },
  {
    "NStefan002/speedtyper.nvim",
    cmd = "Speedtyper",
    opts = {
      -- your config
    },
  },
  {
    "max397574/better-escape.nvim",
    event = "InsertEnter",
    config = function()
      require("better_escape").setup()
    end,
  },
  {
    "christoomey/vim-tmux-navigator",
    lazy = false,
  },
  {
    "folke/noice.nvim",
    -- event = "VeryLazy",
    lazy = false,
    opts = {
      -- add any options here
    },
    dependencies = {
      "MunifTanjim/nui.nvim",
      "rcarriga/nvim-notify",
      {
        "stevearc/dressing.nvim",
        opts = {},
      },
    },
    config = function()
      require "custom.configs.noice"
    end,
  },
  {
    "scalameta/nvim-metals",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "mfussenegger/nvim-dap",
    },
    config = function()
      require("core.utils").load_mappings "lspconfig"
      -- require("telescope").extensions.metals.commands()
    end,
  },
  {
    "mbbill/undotree",
    event = "VeryLazy",
    config = function()
      -- require "custom.configs.undotree"
      require("core.utils").load_mappings "undotree"
    end,
  },
  {
    "NeogitOrg/neogit",
    dependencies = {
      "nvim-lua/plenary.nvim", -- required
      "nvim-telescope/telescope.nvim", -- optional
      "sindrets/diffview.nvim", -- optional
      "ibhagwan/fzf-lua", -- optional
    },
    config = true,
    opts = function()
      local config = require "neogit.config"
      config.auto_show_console = false
      return config
    end,
    ft = { "diff" },
    cmd = { "Neogit" },
    setup = function()
      require("neogit").setup {}
    end,
  },
  {
    "kdheepak/lazygit.nvim",
    -- optional for floating window border decoration
    cmd = { "LazyGit", "LazyGitConfig" },
    dependencies = {
      "nvim-telescope/telescope.nvim",
      "nvim-lua/plenary.nvim",
    },
    event = "VeryLazy",
    config = function()
      require("telescope").load_extension "lazygit"
    end,
  },
  {
    "simrat39/symbols-outline.nvim",
    cmd = "SymbolsOutline",
    config = true,
  },
  {
    "dreamsofcode-io/ChatGPT.nvim",
    event = "VeryLazy",
    dependencies = {
      "MunifTanjim/nui.nvim",
      "nvim-lua/plenary.nvim",
      "nvim-telescope/telescope.nvim",
    },
    config = function()
      require("chatgpt").setup {}
    end,
  },
  --[[ {
    "m4xshen/hardtime.nvim",
    dependencies = {
      "MunifTanjim/nui.nvim",
      "nvim-lua/plenary.nvim",
    },
    event = "VimEnter",
    cmd = { "Hardtime" },
    opts = {
      enabled = true,
      disable_mouse = false,
      restricted_mode = "hint",
      disabled_filetypes = {
        "qf",
        "netrw",
        "NvimTree",
        "lazy",
        "mason",
        "oil",
        "nvterm",
        "term",
        "query",
        "help",
        "NeogitStatus",
        "NeogitPopup",
        "NeogitLogView",
      },
    },
  }, ]]
  --[[ {
    "olimorris/persisted.nvim",
    event = "VimEnter",
    opts = {
      save_dir = vim.fn.expand(vim.fn.stdpath "data" .. "/sessions/"), -- directory where session files are saved
      silent = true, -- silent nvim message when sourcing session file
      use_git_branch = true, -- create session files based on the branch of the git enabled repository
      autosave = true, -- automatically save session files when exiting Neovim
      should_autosave = nil, -- function to determine if a session should be autosaved
      autoload = true, -- automatically load the session for the cwd on Neovim startup
      on_autoload_no_session = nil,
      follow_cwd = false,
      ignored_dirs = {
        -- "~/",
      },
      telescope = { -- options for the telescope extension
        reset_prompt_after_deletion = true, -- whether to reset prompt after session deleted
      },
      config = function(opts)
        vim.o.sessionoptions = "buffers,curdir,options,localoptions,globals,folds,winpos,winsize"
        -- vim.o.sessionoptions = "buffers,curdir,folds,globals,tabpages,winpos,winsize"
        require("persisted").setup(opts)
        require("telescope").load_extension "persisted"
        require("core.utils").load_mappings "persisted"
      end,
    },
  }, ]]
  {
    "olimorris/persisted.nvim",
    event = "VimEnter",
    opts = {
      save_dir = vim.fn.expand(vim.fn.stdpath "data" .. "/sessions/"), -- directory where session files are saved
      silent = true, -- silent nvim message when sourcing session file
      use_git_branch = true, -- create session files based on the branch of the git enabled repository
      autosave = true, -- automatically save session files when exiting Neovim
      should_autosave = nil, -- function to determine if a session should be autosaved
      autoload = true, -- automatically load the session for the cwd on Neovim startup
      on_autoload_no_session = nil,
      follow_cwd = true,
      -- ignored_dirs = {
      --   "~/.config",
      --   "~/.local/nvim",
      -- },
      telescope = { -- options for the telescope extension
        reset_prompt_after_deletion = true, -- whether to reset prompt after session deleted
      },
      config = function()
        require("persisted").setup(opts)
        require("telescope").load_extension "persisted"
      end,
    },
  },
  {
    "hiphish/rainbow-delimiters.nvim",
    event = "BufReadPost",
    config = function()
      local rainbow_delimiters = require "rainbow-delimiters"

      vim.g.rainbow_delimiters = {
        strategy = {
          [""] = rainbow_delimiters.strategy["global"],
          vim = rainbow_delimiters.strategy["local"],
        },
        query = {
          [""] = "rainbow-delimiters",
          lua = "rainbow-blocks",
        },
        highlight = {
          "RainbowDelimiterRed",
          "RainbowDelimiterYellow",
          "RainbowDelimiterBlue",
          "RainbowDelimiterOrange",
          "RainbowDelimiterGreen",
          "RainbowDelimiterViolet",
          "RainbowDelimiterCyan",
        },
      }
    end,
  },
  {
    "nvim-neotest/neotest",
    ft = { "python", "c", "cpp", "scala" },
    dependencies = {
      "stevanmilic/neotest-scala",
      "antoinemadec/FixCursorHold.nvim",
      "nvim-neotest/neotest-python",
      "nvim-neotest/neotest-plenary",
      "nvim-neotest/neotest-vim-test",
    },
    config = function()
      require "custom.configs.neotest"
    end,
  },
  {
    "smoka7/multicursors.nvim",
    cmd = { "MCstart", "MCvisual", "MCclear", "MCpattern", "MCvisualPattern", "MCunderCursor" },
    opts = {
      updatetime = 10,
    },
    dependencies = {
      "smoka7/hydra.nvim",
    },
  },
  {
    "RRethy/vim-illuminate",
    event = { "CursorHold", "CursorHoldI" },
    config = function()
      require "custom.configs.illuminate"
    end,
  },
  {
    "Wansmer/treesj",
    config = function()
      require("treesj").setup {
        use_default_keymaps = true,
      }
    end,
  },
  {
    "nvim-telescope/telescope.nvim",
    opts = overrides.telescope,
    dependencies = {
      "debugloop/telescope-undo.nvim",
      "gnfisher/nvim-telescope-ctags-plus",
      "tom-anders/telescope-vim-bookmarks.nvim",
      "benfowler/telescope-luasnip.nvim",
      "Marskey/telescope-sg",
      {
        "nvim-telescope/telescope-fzf-native.nvim",
        build = "make",
      },
      {
        "nvim-telescope/telescope-frecency.nvim",
        dependencies = { "kkharji/sqlite.lua" },
      },
      {
        "nvim-telescope/telescope-ui-select.nvim",
        event = "VeryLazy",
        config = function()
          require("telescope").load_extension "ui-select"
        end,
      },
      {
        "nvim-telescope/telescope-file-browser.nvim",
        dependencies = { "nvim-telescope/telescope.nvim", "nvim-lua/plenary.nvim" },
      },
    },
  },
  {
    "echasnovski/mini.nvim",
    event = "VeryLazy",
    config = function()
      require("mini.animate").setup {
        scroll = {
          enable = false,
        },
      }
    end,
  },
  {
    "gorbit99/codewindow.nvim",
    -- keys = { "<leader>mm" },
    config = function()
      require("codewindow").setup {
        show_cursor = false,
        window_border = "rounded",
        z_index = 30,
        events = { "TextChanged", "InsertLeave", "DiagnosticChanged", "FileWritePost" },
        exclude_filetypes = {
          "help",
          "NvimTree",
          "nvdash",
          "nvcheatsheet",
          "terminal",
          "Trouble",
          "fugitive",
        },
      }
    end,
  },
  {
    "sindrets/diffview.nvim",
    cmd = "DiffviewOpen",
    config = function()
      require("diffview").setup {
        enhanced_diff_hl = true,
        view = {
          merge_tool = {
            layout = "diff3_mixed",
            disable_diagnostics = true,
          },
        },
      }
    end,
  },
  {
    "tzachar/highlight-undo.nvim",
    event = "BufReadPost",
    config = function()
      require("highlight-undo").setup {}
    end,
  },
  {
    "kosayoda/nvim-lightbulb",
    event = "BufWinEnter",
    config = function()
      require("nvim-lightbulb").setup {
        autocmd = { enabled = true },
        sign = { enabled = false },
        virtual_text = { enabled = true, text = "💡" },
        ignore = {
          -- LSP client names to ignore.
          -- Example: {"null-ls", "lua_ls"}
          clients = {},
          -- Filetypes to ignore.
          -- Example: {"neo-tree", "lua"}
          ft = {},
          -- Ignore code actions without a `kind` like refactor.rewrite, quickfix.
          actions_without_kind = false,
        },
      }
    end,
  },
  {
    "weilbith/nvim-code-action-menu",
    cmd = "CodeActionMenu",
    init = function()
      vim.g.code_action_menu_show_details = true
      vim.g.code_action_menu_show_diff = true
      vim.g.code_action_menu_show_action_kind = true
    end,
    config = function()
      dofile(vim.g.base46_cache .. "git")
    end,
  },
  {
    "mawkler/modicator.nvim",
    event = "BufWinEnter",
    init = function()
      vim.o.cursorline = true
      vim.o.number = true
      vim.o.termguicolors = true
    end,
    config = function()
      require("modicator").setup()
    end,
  },
  {
    "m-demare/hlargs.nvim",
    event = "BufWinEnter",
    config = function()
      require("hlargs").setup {
        hl_priority = 200,
      }
    end,
  },
  {
    "Vigemus/iron.nvim",
    keys = {
      { "<leader>i", vim.cmd.IronRepl, desc = "󱠤 Toggle REPL" },
      { "<leader>I", vim.cmd.IronRestart, desc = "󱠤 Restart REPL" },

      -- these keymaps need no right-hand-side, since that is defined by the
      -- plugin config further below
      { "+", mode = { "n", "x" }, desc = "󱠤 Send-to-REPL Operator" },
      { "++", desc = "󱠤 Send Line to REPL" },
    },

    -- since irons's setup call is `require("iron.core").setup`, instead of
    -- `require("iron").setup` like other plugins would do, we need to tell
    -- lazy.nvim which module to via the `main` key
    main = "iron.core",

    opts = {
      keymaps = {
        send_line = "++",
        visual_send = "+",
        send_motion = "+",
      },
      config = {
        -- this defined how the repl is opened. Here we set the REPL window
        -- to open in a horizontal split to a bottom, with a height of 10
        -- cells.
        repl_open_cmd = "horizontal bot 10 split",

        -- This defines which binary to use for the REPL. If `ipython` is
        -- available, it will use `ipython`, otherwise it will use `python3`.
        -- since the python repl does not play well with indents, it's
        -- preferable to use `ipython` or `bypython` here.
        -- (see: https://github.com/Vigemus/iron.nvim/issues/348)
        repl_definition = {
          python = {
            command = function()
              local ipythonAvailable = vim.fn.executable "ipython" == 1
              local binary = ipythonAvailable and "ipython" or "python3"
              return { binary }
            end,
          },
          ocaml = {
            command = function()
              local utopAvailable = vim.fn.executable "utop" == 1
              local binary = utopAvailable and "utop" or "ocaml"
              return { binary }
            end,
          },
        },
      },
    },
  },
  {
    "danymat/neogen",
    dependencies = "nvim-treesitter/nvim-treesitter",
    config = true,
    -- Uncomment next line if you want to follow only stable versions
    -- version = "*"
  },
  {
    "chrisgrieser/nvim-puppeteer",
    dependencies = "nvim-treesitter/nvim-treesitter",
    ft = "python",
  },

  -- better indentation behavior
  -- by default, vim has some weird indentation behavior in some edge cases,
  -- which this plugin fixes
  { "Vimjas/vim-python-pep8-indent", ft = "python" },

  -- select virtual environments
  -- - makes pyright and debugpy aware of the selected virtual environment
  -- - Select a virtual environment with `:VenvSelect`
  {
    "linux-cultist/venv-selector.nvim",
    event = "BufReadPre",
    dependencies = {
      "neovim/nvim-lspconfig",
      "nvim-telescope/telescope.nvim",
      "mfussenegger/nvim-dap-python",
    },
    opts = {
      dap_enabled = true, -- makes the debugger work with venv
    },
  },
  {
    "karb94/neoscroll.nvim",
    event = "VeryLazy",
    config = function()
      require("neoscroll").setup {
        -- All these keys will be mapped to their corresponding default scrolling animation
        mappings = { "<C-u>", "<C-d>", "<C-b>", "<C-f>", "<C-y>", "<C-e>", "zt", "zz", "zb" },
        hide_cursor = true, -- Hide cursor while scrolling
        stop_eof = true, -- Stop at <EOF> when scrolling downwards
        respect_scrolloff = true, -- Stop scrolling when the cursor reaches the scrolloff margin of the file
        cursor_scrolls_alone = false, -- The cursor will keep on scrolling even if the window cannot scroll further
        easing_function = nil, -- Default easing function
        pre_hook = function()
          vim.opt.eventignore:append {
            "WinScrolled",
            "CursorMoved",
          }
          require("treesitter-context").disable()
        end, -- Function to run before the scrolling animation starts
        post_hook = function()
          vim.opt.eventignore:remove {
            "WinScrolled",
            "CursorMoved",
          }
          require("treesitter-context").enable()
        end, -- Function to run after the scrolling animation ends
        performance_mode = false, -- Disable "Performance Mode" on all buffers.
      }
    end,
  },
  {
    "folke/trouble.nvim",
    event = "VeryLazy",
    opts = function()
      require "custom.configs.trouble"
      require("core.utils").load_mappings "trouble"
    end,
  },
  {
    "folke/zen-mode.nvim",
    event = "VeryLazy",
    config = function()
      require "custom.configs.zenmode"
    end,
  },
  {
    "ThePrimeagen/vim-be-good",
    event = "VeryLazy",
  },
  {
    "ThePrimeagen/harpoon",
    event = "VeryLazy",
  },
  {
    "tpope/vim-fugitive",
    event = "VeryLazy",
    config = function()
      require "custom.configs.fugitive"
    end,
  },
  {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
    event = { "BufReadPre", "BufNewFile" },
    dependencies = {
      {
        "nvim-treesitter/nvim-treesitter-textobjects",
        lazy = true,
        config = function()
          require("nvim-treesitter.configs").setup {}
          local ts_repeat_move = require "nvim-treesitter.textobjects.repeatable_move"

          -- vim way: ; goes to the direction you were moving.
          vim.keymap.set({ "n", "x", "o" }, ";", ts_repeat_move.repeat_last_move)
          vim.keymap.set({ "n", "x", "o" }, ",", ts_repeat_move.repeat_last_move_opposite)

          -- Optionally, make builtin f, F, t, T also repeatable with ; and ,
          vim.keymap.set({ "n", "x", "o" }, "f", ts_repeat_move.builtin_f)
          vim.keymap.set({ "n", "x", "o" }, "F", ts_repeat_move.builtin_F)
          vim.keymap.set({ "n", "x", "o" }, "t", ts_repeat_move.builtin_t)
          vim.keymap.set({ "n", "x", "o" }, "T", ts_repeat_move.builtin_T)
        end,
      },
    },
    opts = overrides.treesitter,
  },
  {
    "nvim-treesitter/nvim-treesitter-context",
    event = "BufWinEnter",
    opts = {
      throttle = true,
      patterns = {
        default = {
          "class",
          "function",
          "method",
        },
      },
    },
  },
  {
    "mfussenegger/nvim-dap-python",
    ft = "python",
    dependencies = {
      "mfussenegger/nvim-dap",
      "rcarriga/nvim-dap-ui",
    },
    config = function(_, opts)
      opts = opts
      local path = "~/.pyenv/shims/python3"
      require("dap-python").setup(path)
      require("core.utils").load_mappings "dap_python"
    end,
  },
  {
    "rcarriga/nvim-dap-ui",
    event = "VeryLazy",
    dependencies = "mfussenegger/nvim-dap",
    config = function()
      local dap = require "dap"
      local dapui = require "dapui"
      dapui.setup()
      dap.listeners.after.event_initialized["dapui_config"] = function()
        dapui.open()
      end
      dap.listeners.before.event_terminated["dapui_config"] = function()
        dapui.close()
      end
      dap.listeners.before.event_exited["dapui_config"] = function()
        dapui.close()
      end
    end,
  },
  {
    "williamboman/mason.nvim",
    opts = overrides.mason,
  },
  {
    "jay-babu/mason-nvim-dap.nvim",
    event = "VeryLazy",
    config = function()
      require "custom.configs.dap"
    end,
    dependencies = {
      {
        "williamboman/mason.nvim",
      },
      "mfussenegger/nvim-dap",
      {
        "theHamsta/nvim-dap-virtual-text",
        config = function()
          require "custom.configs.virtual-text"
        end,
      },
    },
    opts = {
      handlers = {},
    },
  },
  {
    "mfussenegger/nvim-dap",
    config = function(_, _)
      require("core.utils").load_mappings "dap"
    end,
  },
  {
    "tpope/vim-dadbod",
    cmd = { "DBUI" },
    dependencies = {
      "kristijanhusak/vim-dadbod-ui",
      "kristijanhusak/vim-dadbod-completion",
    },
    opts = {
      db_completion = function()
        require("cmp").setup.buffer { sources = { { name = "vim-dadbod-completion" } } }
      end,
    },
    config = function(_, opts)
      vim.g.db_ui_save_location = vim.fn.stdpath "config" .. require("plenary.path").path.sep .. "db_ui"

      vim.api.nvim_create_autocmd("FileType", {
        pattern = {
          "sql",
        },
        command = [[setlocal omnifunc=vim_dadbod_completion#omni]],
      })

      vim.api.nvim_create_autocmd("FileType", {
        pattern = {
          "sql",
          "mysql",
          "plsql",
        },
        callback = function()
          vim.schedule(opts.db_completion)
        end,
      })
    end,
    keys = {
      { "<leader>Dt", "<cmd>DBUIToggle<cr>", desc = "Toggle UI" },
      { "<leader>Df", "<cmd>DBUIFindBuffer<cr>", desc = "Find Buffer" },
      { "<leader>Dr", "<cmd>DBUIRenameBuffer<cr>", desc = "Rename Buffer" },
      { "<leader>Dq", "<cmd>DBUILastQueryInfo<cr>", desc = "Last Query Info" },
    },
  },
  {
    "folke/todo-comments.nvim",
    event = "BufReadPost",
    config = function()
      require "custom.configs.todo"
    end,
  },
  {
    "hrsh7th/nvim-cmp",
    opts = cmp_opt.cmp,
    event = "VeryLazy",
    dependencies = {
      "delphinus/cmp-ctags",
      "hrsh7th/cmp-cmdline",
      "hrsh7th/cmp-nvim-lsp",
      "hrsh7th/cmp-nvim-lsp-document-symbol",
      "hrsh7th/cmp-nvim-lsp-signature-help",
      "saadparwaiz1/cmp_luasnip",
      "onsails/lspkind-nvim",
      "hrsh7th/cmp-copilot",
      --[[ {
        "zbirenbaum/copilot-cmp",
        event = { "InsertEnter", "LspAttach" },
        fix_pairs = true,
      }, ]]
      "ray-x/cmp-treesitter",
      "nvim-treesitter/nvim-treesitter-textobjects",
      "chrisgrieser/nvim-various-textobjs",
      "filNaj/tree-setter",
      "RRethy/nvim-treesitter-textsubjects",
      {
        "echasnovski/mini.surround",
        version = "*",
        event = { "ModeChanged" },
        config = true,
      },
      "js-everts/cmp-tailwind-colors",
      {
        "jcdickinson/codeium.nvim",
        event = { "InsertEnter", "LspAttach" },
        config = function()
          require("codeium").setup()
        end,
      },
      {
        "L3MON4D3/LuaSnip",
        config = function(_, opts)
          require("plugins.configs.others").luasnip(opts)
          require "custom.configs.luasnip"
        end,
      },
      {
        "zbirenbaum/copilot.lua",
        event = "InsertEnter",
        dependencies = {
          {
            "zbirenbaum/copilot-cmp",
            config = function()
              require("copilot_cmp").setup()
            end,
          },
        },
        config = function()
          require("copilot").setup {
            suggestion = {
              enabled = true,
              auto_trigger = true,
              keymap = {
                accept = "<M-\\>",
                accept_word = false,
                accept_line = false,
                next = "<M-]>",
                prev = "<M-[>",
                dismiss = "<C-]>",
              },
            },
            panel = {
              enabled = false,
            },
            filetypes = {
              gitcommit = false,
              TelescopePrompt = false,
            },
            server_opts_overrides = {
              trace = "verbose",
              settings = {
                advanced = {
                  listCount = 3,
                  inlineSuggestCount = 3,
                },
              },
            },
          }
        end,
      },
    },
    config = function(_, opts)
      dofile(vim.g.base46_cache .. "cmp")
      local format_kinds = opts.formatting.format
      opts.formatting.format = function(entry, item)
        if item.kind == "Color" then
          item = require("cmp-tailwind-colors").format(entry, item)
          if item.kind == "Color" then
            return format_kinds(entry, item)
          end
          return item
        end
        return format_kinds(entry, item)
      end
      -- table.insert(opts.sources, { name = "codeium" })
      require("cmp").setup(opts)
    end,
  },
  -- "onsails/lspkind-nvim",
  {
    "kevinhwang91/nvim-ufo",
    dependencies = {
      "kevinhwang91/promise-async",
      {
        "luukvbaal/statuscol.nvim",
        config = function()
          require "custom.configs.statuscol"
        end,
      },
    },
    lazy = false,
    init = function()
      vim.o.fillchars = [[eob: ,fold: ,foldopen:,foldsep: ,foldclose:]]
      vim.o.foldcolumn = "1" -- '0' is not bad
      vim.o.foldlevel = 99 -- Using ufo provider need a large value, feel free to decrease the value
      vim.o.foldlevelstart = 99
      vim.o.foldenable = true -- Disable fold by default
    end,
    config = function()
      require "custom.configs.ufo"
      require("core.utils").load_mappings "ufo"
    end,
  },
}

return plugins
