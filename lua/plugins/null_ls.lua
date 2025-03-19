return {
  "nvimtools/none-ls.nvim",
  dependencies = { "nvim-lua/plenary.nvim" }, -- Make sure plenary is a dependency
  config = function()
    local null_ls = require "null-ls"

    null_ls.setup {
      sources = {
        -- -- Ruff for linting and autofixing
        -- null_ls.builtins.diagnostics.ruff.with({
        --   command = vim.fn.stdpath("data") .. "/mason/bin/ruff",
        --   args = { "--fix", "--stdin-filename", "$FILENAME", "-" },  -- Enabling autofix
        -- }),
        -- Black for formatting
        null_ls.builtins.formatting.black.with {
          command = vim.fn.stdpath "data" .. "/mason/bin/black",
        },

        -- Mypy for type checking
        null_ls.builtins.diagnostics.mypy.with {
          command = vim.fn.stdpath "data" .. "/mason/bin/mypy",
          args = { "--strict", "--show-column-numbers", "--show-error-codes", "--check-untyped-defs", "$FILENAME" },
          filetypes = { "python" }, -- Ensure this only runs for Python files
        },
      },
      on_attach = function(client, bufnr)
        -- Formatting on save
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
  end,
}
