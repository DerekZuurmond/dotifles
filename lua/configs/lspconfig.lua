--
--
-- Load NvChad default LSP settings
require("nvchad.configs.lspconfig").defaults()

local lspconfig = require "lspconfig"
local nvlsp = require "nvchad.configs.lspconfig"
local null_ls = require "null-ls"

-- List of LSPs with default configurations
local servers = { "lua_ls", "sqlls", "ruff" }

for _, lsp in ipairs(servers) do
  lspconfig[lsp].setup {
    on_attach = nvlsp.on_attach,
    on_init = nvlsp.on_init,
    capabilities = nvlsp.capabilities,
  }
end

-- lspconfig.ruff.setup({
--   init_options = {
--     settings = {
--       -- Ruff language server settings go here
--     }
--   }
-- })

lspconfig.pylsp.setup {
  settings = {
    pylsp = {
      plugins = {
        pycodestyle = {
          ignore = { 'W391' },
          maxLineLength = 100
        }
      }
    }
  }
}

-- Specific LSP configurations
lspconfig.lua_ls.setup {
  on_attach = nvlsp.on_attach,
  on_init = nvlsp.on_init,
  capabilities = nvlsp.capabilities,
  settings = {
    Lua = {
      diagnostics = {
        globals = { "vim" },
      },
      workspace = {
        library = {
          [vim.fn.expand "$VIMRUNTIME/lua"] = true,
          [vim.fn.expand "$VIMRUNTIME/lua/vim/lsp"] = true,
          [vim.fn.stdpath "data" .. "/lazy/ui/nvchad_types"] = true,
          [vim.fn.stdpath "data" .. "/lazy/lazy.nvim/lua/lazy"] = true,
        },
        maxPreload = 100000,
        preloadFileSize = 10000,
      },
    },
  },
}

-- lspconfig.pyright.setup {
--   on_attach = function(client, bufnr)
--     client.server_capabilities.signatureHelpProvider = false
--   end,
--   on_init = nvlsp.on_init,
--   -- capabilities = nvlsp.capabilities,
--   capabilities = require("nvchad.configs.lspconfig").capabilities,
--   settings = {
--     python = {
--       analysis = {
--         typeCheckingMode = "strict",
--         autoSearchPaths = true,
--         useLibraryCodeForTypes = true,
--       },
--     },
--   },
-- }

-- Null LS setup for extra diagnostics and formatting
null_ls.setup {
  sources = {
    null_ls.builtins.diagnostics.mypy.with {
      command = vim.fn.stdpath "data" .. "/mason/bin/mypy",
      args = { "--strict", "--show-column-numbers", "--show-error-codes", "--check-untyped-defs", "$FILENAME" },
      filetypes = { "python" },
    },
    null_ls.builtins.diagnostics.pylint,
  },
  on_attach = function(client, bufnr)
    if client.server_capabilities.documentFormattingProvider then
      vim.api.nvim_create_autocmd("BufWritePre", {
        buffer = bufnr,
        callback = function()
          vim.lsp.buf.format { bufnr = bufnr }
        end,
      })
    end
  end,
}

-- vim.lsp.handlers["textDocument/signatureHelp"] = function() end
