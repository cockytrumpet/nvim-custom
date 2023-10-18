require("neodev").setup {
  -- add any options here, or leave empty to use the default settings
}

local c = require("plugins.configs.lspconfig").capabilities
---@diagnostic disable-next-line: inject-field
c.textDocument.completion.completionItem.snippetSupport = true
---@diagnostic disable-next-line: inject-field
c.textDocument.completion.completionItem.resolveSupport = {
  properties = {
    "documentation",
    "detail",
    "additionalTextEdits",
  },
}
local capabilities = require("cmp_nvim_lsp").default_capabilities(c)

local present, cmp_nvim_lsp = pcall(require, "cmp_nvim_lsp")
if present then
  capabilities = cmp_nvim_lsp.default_capabilities(capabilities)
end

local present2, _ = pcall(require, "ufo")
if present2 then
  capabilities.textDocument.foldingRange = {
    dynamicRegistration = false,
    lineFoldingOnly = true,
  }
end

local on_attach = function(client, bufnr)
  if client.server_capabilities.inlayHintProvider then
    vim.lsp.inlay_hint(bufnr, true)
  end
  if client.server_capabilities.code_lens then
    -- if client.supports_method "textDocument/codeLens" then
    local codelens = vim.api.nvim_create_augroup("LSPCodeLens", { clear = true })
    vim.api.nvim_create_autocmd({ "BufEnter", "InsertLeave", "CursorHold" }, {
      group = codelens,
      callback = function()
        vim.lsp.codelens.refresh()
      end,
      buffer = bufnr,
    })
  end
  return require("plugins.configs.lspconfig").on_attach
end

---@diagnostic disable-next-line: different-requires
local lspconfig = require "lspconfig"

-- if you just want default config for the servers then put them in a table
local servers = { "html", "cssls", "jsonls", "yamlls", "dockerls", "docker_compose_language_service" }

for _, lsp in ipairs(servers) do
  lspconfig[lsp].setup {
    on_attach = on_attach,
    capabilities = capabilities,
  }
end

lspconfig.ocamllsp.setup {
  on_attach = on_attach,
  capabilities = capabilities,
  cmd = { "ocamllsp" },
  filetypes = { "ocaml", "ocaml_interface", "ocamllex", "reason", "dune" },
  root_dir = lspconfig.util.root_pattern("*.opam", "esy.json", "package.json", "esy.lock", "dune", "bsconfig.json"),
}

lspconfig.clangd.setup {
  on_attach = on_attach,
  capabilities = capabilities,
  cmd = {
    "clangd",
    "--offset-encoding=utf-16",
  },
}

lspconfig.pyright.setup {
  on_attach = on_attach,
  capabilities = capabilities,
  cmd = { "pyright-langserver", "--stdio", "--pythonPath ", "/Users/adam/.pyenv/shims/python3" },
  filetypes = { "python" },
  settings = {
    python = {
      analysis = {
        typeCheckingMode = "basic",
        autoSearchPaths = true,
        useLibraryCodeForTypes = true,
        diagnosticMode = "workspace",
      },
      pyright = {
        autoImportCompletion = true,
      },
    },
  },
  -- single_file = true,
}

lspconfig.ruff_lsp.setup {
  -- organize imports disabled, since we are already using `isort` for that
  -- alternative, this can be enabled to make `organize imports`
  -- available as code action
  settings = {
    organizeImports = false,
  },
  -- disable ruff as hover provider to avoid conflicts with pyright
  on_attach = function(client)
    client.server_capabilities.hoverProvider = false
  end,
}

-- Metals setup
local api = vim.api
-- local cmd = vim.cmd
local metals_config = require("metals").bare_config()

metals_config.settings = {
  showImplicitArguments = true,
  excludedPackages = { "akka.actor.typed.javadsl", "com.github.swagger.akka.javadsl" },
  showInferredType = true,
  superMethodLensesEnabled = true,
  enableSemanticHighlighting = false,
  showImplicitConversionsAndClasses = true,
}

-- *READ THIS*
-- I *highly* recommend setting statusBarProvider to true, however if you do,
-- you *have* to have a setting to display this in your statusline or else
-- you'll not see any messages from metals. There is more info in the help
-- docs about this
-- metals_config.init_options.statusBarProvider = "on"

-- Example if you are using cmp how to make sure the correct capabilities for snippets are set
metals_config.capabilities = require("cmp_nvim_lsp").default_capabilities(capabilities)

---@diagnostic disable-next-line: unused-local
metals_config.on_attach = function(client, bufnr)
  require("metals").setup_dap()
end

-- Autocmd that will actually be in charging of starting the whole thing
local nvim_metals_group = api.nvim_create_augroup("nvim-metals", { clear = true })
api.nvim_create_autocmd("FileType", {
  -- NOTE: You may or may not want java included here. You will need it if you
  -- want basic Java support but it may also conflict if you are using
  -- something like nvim-jdtls which also works on a java filetype autocmd.
  pattern = { "scala", "sbt", "java" },
  callback = function()
    require("metals").initialize_or_attach(metals_config)
  end,
  group = nvim_metals_group,
})

vim.diagnostic.config {
  virtual_lines = false,
  virtual_text = {
    source = "always",
    prefix = "■",
  },
  -- virtual_text = false,
  float = {
    source = "always",
    border = "rounded",
  },
  signs = true,
  underline = false,
  update_in_insert = false,
  severity_sort = true,
}
