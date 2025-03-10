-- All plugins have lazy=true by default,to load a plugin on startup just lazy=false
-- List of all default plugins & their definitions
local default_plugins = {

  "nvim-lua/plenary.nvim",

  {
    "NvChad/base46",
    branch = "v2.0",
    build = function()
      require("base46").load_all_highlights()
    end,
  },

  {
    "NvChad/ui",
    branch = "v2.0",
    lazy = false,
  },

  {
    "zbirenbaum/nvterm",
    init = function()
      require("core.utils").load_mappings "nvterm"
    end,
    config = function(_, opts)
      require "base46.term"
      require("nvterm").setup(opts)
    end,
  },

  {
    "NvChad/nvim-colorizer.lua",
    event = "User FilePost",
    config = function(_, opts)
      require("colorizer").setup(opts)

      -- execute colorizer as soon as possible
      vim.defer_fn(function()
        require("colorizer").attach_to_buffer(0)
      end, 0)
    end,
  },

  {
    "nvim-tree/nvim-web-devicons",
    opts = function()
      return { override = require "nvchad.icons.devicons" }
    end,
    config = function(_, opts)
      dofile(vim.g.base46_cache .. "devicons")
      require("nvim-web-devicons").setup(opts)
    end,
  },

  {
    "lukas-reineke/indent-blankline.nvim",
    version = "2.20.7",
    event = "User FilePost",
    opts = function()
      return require("plugins.configs.others").blankline
    end,
    config = function(_, opts)
      require("core.utils").load_mappings "blankline"
      dofile(vim.g.base46_cache .. "blankline")
      require("indent_blankline").setup(opts)
    end,
  },

  {
    "nvim-treesitter/nvim-treesitter",
    event = { "BufReadPost", "BufNewFile" },
    cmd = { "TSInstall", "TSBufEnable", "TSBufDisable", "TSModuleInfo" },
    build = ":TSUpdate",
    opts = function()
      return require "plugins.configs.treesitter"
    end,
    config = function(_, opts)
      dofile(vim.g.base46_cache .. "syntax")
      require("nvim-treesitter.configs").setup(opts)
    end,
  },

  -- git stuff
  {
    "lewis6991/gitsigns.nvim",
    event = "User FilePost",
    opts = function()
      return require("plugins.configs.others").gitsigns
    end,
    config = function(_, opts)
      dofile(vim.g.base46_cache .. "git")
      require("gitsigns").setup(opts)
    end,
  },

  -- lsp stuff
  {
    "williamboman/mason.nvim",
    cmd = { "Mason", "MasonInstall", "MasonInstallAll", "MasonUpdate" },
    opts = function()
      return require "plugins.configs.mason"
    end,
    config = function(_, opts)
      dofile(vim.g.base46_cache .. "mason")
      require("mason").setup(opts)

      -- custom nvchad cmd to install all mason binaries listed
      vim.api.nvim_create_user_command("MasonInstallAll", function()
        if opts.ensure_installed and #opts.ensure_installed > 0 then
          vim.cmd("MasonInstall " .. table.concat(opts.ensure_installed, " "))
        end
      end, {})

      vim.g.mason_binaries_list = opts.ensure_installed
    end,
  },


  {
        "williamboman/mason-lspconfig.nvim",
  },


  {
    "neovim/nvim-lspconfig",
    event = "User FilePost",
    config = function()
      require "plugins.configs.lspconfig"
    end,
  },

  -- load luasnips + cmp related in insert mode only
  {
    "hrsh7th/nvim-cmp",
    event = "InsertEnter",
    dependencies = {
      {
        -- snippet plugin
        "L3MON4D3/LuaSnip",
        dependencies = "rafamadriz/friendly-snippets",
        opts = { history = true, updateevents = "TextChanged,TextChangedI" },
        config = function(_, opts)
          require("plugins.configs.others").luasnip(opts)
        end,
      },

      -- autopairing of (){}[] etc
      {
        "windwp/nvim-autopairs",
        opts = {
          fast_wrap = {},
          disable_filetype = { "TelescopePrompt", "vim" },
        },
        config = function(_, opts)
          require("nvim-autopairs").setup(opts)

          -- setup cmp for autopairs
          local cmp_autopairs = require "nvim-autopairs.completion.cmp"
          require("cmp").event:on("confirm_done", cmp_autopairs.on_confirm_done())
        end,
      },

      -- cmp sources plugins
      {
        "saadparwaiz1/cmp_luasnip",
        "hrsh7th/cmp-nvim-lua",
        "hrsh7th/cmp-nvim-lsp",
        "hrsh7th/cmp-buffer",
        "hrsh7th/cmp-path",
      },
    },
    opts = function()
      return require "plugins.configs.cmp"
    end,
    config = function(_, opts)
      require("cmp").setup(opts)
    end,
  },

  {
    "numToStr/Comment.nvim",
    keys = {
      { "gcc", mode = "n", desc = "Comment toggle current line" },
      { "gc", mode = { "n", "o" }, desc = "Comment toggle linewise" },
      { "gc", mode = "x", desc = "Comment toggle linewise (visual)" },
      { "gbc", mode = "n", desc = "Comment toggle current block" },
      { "gb", mode = { "n", "o" }, desc = "Comment toggle blockwise" },
      { "gb", mode = "x", desc = "Comment toggle blockwise (visual)" },
    },
    init = function()
      require("core.utils").load_mappings "comment"
    end,
    config = function(_, opts)
      require("Comment").setup(opts)
    end,
  },

  -- file managing , picker etc
  {
    "nvim-tree/nvim-tree.lua",
    cmd = { "NvimTreeToggle", "NvimTreeFocus" },
    init = function()
      require("core.utils").load_mappings "nvimtree"
    end,
    opts = function()
      return require "plugins.configs.nvimtree"
    end,
    config = function(_, opts)
      dofile(vim.g.base46_cache .. "nvimtree")
      require("nvim-tree").setup(opts)
    end,
  },

  {
    "nvim-telescope/telescope.nvim",
    dependencies = { "nvim-treesitter/nvim-treesitter" },
    cmd = "Telescope",
    init = function()
      require("core.utils").load_mappings "telescope"
    end,
    opts = function()
      return require "plugins.configs.telescope"
    end,
    config = function(_, opts)
      dofile(vim.g.base46_cache .. "telescope")
      local telescope = require "telescope"
      telescope.setup(opts)
      telescope.load_extension("refactoring")

      -- load extensions
      for _, ext in ipairs(opts.extensions_list) do
        telescope.load_extension(ext)
      end
    end,
  },

  -- Only load whichkey after all the gui
  {
    "folke/which-key.nvim",
    keys = { "<leader>", "<c-r>", "<c-w>", '"', "'", "`", "c", "v", "g" },
    init = function()
      require("core.utils").load_mappings "whichkey"
    end,
    cmd = "WhichKey",
    config = function(_, opts)
      dofile(vim.g.base46_cache .. "whichkey")
      require("which-key").setup(opts)
    end,
  },


{
  "jose-elias-alvarez/null-ls.nvim",
  dependencies = { "nvim-lua/plenary.nvim" },  -- Make sure plenary is a dependency
  config = function()
      local null_ls = require("null-ls")


null_ls.setup({
  sources = {
    -- -- Ruff for linting and autofixing
    -- null_ls.builtins.diagnostics.ruff.with({
    --   command = vim.fn.stdpath("data") .. "/mason/bin/ruff",
    --   args = { "--fix", "--stdin-filename", "$FILENAME", "-" },  -- Enabling autofix
    -- }),
    -- Black for formatting
    null_ls.builtins.formatting.black.with({
      command = vim.fn.stdpath("data") .. "/mason/bin/black",
    }),

    -- Mypy for type checking
    null_ls.builtins.diagnostics.mypy.with({
      command = vim.fn.stdpath("data") .. "/mason/bin/mypy",
      args = { "--strict", "--show-column-numbers", "--show-error-codes", "--check-untyped-defs", "$FILENAME" },
      filetypes = { "python" },  -- Ensure this only runs for Python files
    }),
  },
  on_attach = function(client, bufnr)
    -- Formatting on save
    if client.server_capabilities.documentFormattingProvider then
      vim.api.nvim_create_autocmd("BufWritePre", {
        buffer = bufnr,
        callback = function()
          vim.lsp.buf.format({ bufnr = bufnr })
        end,
      })
    end
  end,
})

  end,
},

    {
        "ThePrimeagen/refactoring.nvim",
        requires = {
            {"nvim-lua/plenary.nvim"},
            {"nvim-treesitter/nvim-treesitter"}
        },
        config = function()
            require('refactoring').setup({})
        end,
    },


  {
    "christoomey/vim-tmux-navigator",
    lazy = false,
  },

  {
    "iamcco/markdown-preview.nvim",
    cmd = { "MarkdownPreviewToggle", "MarkdownPreview", "MarkdownPreviewStop" },
    ft = { "markdown" },
    build = function() vim.fn["mkdp#util#install"]() end,
},

-- {
--   "rcarriga/nvim-notify",
--   config = function()
--     require("notify").setup({
--       enable = false,   -- The boolean value indicating whether to enable the plugin
--     })
--   end,
-- },

{ "catppuccin/nvim", name = "catppuccin", priority = 1000 },
{
  "folke/noice.nvim",
  event = "VeryLazy",
  opts = {
    -- add any options here
  },
  dependencies = {
    -- if you lazy-load any plugin below, make sure to add proper `module="..."` entries
    "MunifTanjim/nui.nvim",
    -- OPTIONAL:
    --   `nvim-notify` is only needed, if you want to use the notification view.
    --   If not available, we use `mini` as the fallback
    "rcarriga/nvim-notify",
  }
},


{
  "folke/todo-comments.nvim",
  dependencies = { "nvim-lua/plenary.nvim" },
  opts = {
    -- your configuration comes here
    -- or leave it empty to use the default settings
    -- refer to the configuration section below
  }
},


{
  "github/copilot.vim",
  lazy = false,
  config = function()
    vim.g.copilot_no_tab_map = true;
    vim.g.copilot_assume_mapped = true;
    vim.g.copilot_tab_fallback = "";
    vim.api.nvim_set_keymap("i", "<leader>i", "copilot#Accept('<CR>')", { silent = true, expr = true, noremap = true })
  end,
},
{
   "m4xshen/hardtime.nvim",
   event = {"BufRead", "BufNewFile", "VeryLazy"},
   dependencies = { "MunifTanjim/nui.nvim", "nvim-lua/plenary.nvim" },
   config = function()
      require("hardtime").setup({
         -- Add your configuration here if needed
      })
   end,
},


{
    "yetone/avante.nvim",
    event = "VeryLazy",
    lazy = false,
    version = false, -- Always pull the latest changes
    opts = {
      provider = "copilot", -- Set GitHub Copilot as the provider
      auto_suggestions_provider = "copilot", -- Use Copilot for auto-suggestions
      copilot = {
        -- Additional configuration for Copilot, if needed
      },
      behaviour = {
        auto_suggestions = true, -- Enable auto-suggestions
        auto_set_highlight_group = true,
        auto_set_keymaps = true,
        auto_apply_diff_after_generation = true,
        support_paste_from_clipboard = false,
        minimize_diff = true,
      },
      mappings = {
            sidebar = {
      apply_all = "<leader>A",
      apply_cursor = "a",
      switch_windows = "<Tab>",
      reverse_switch_windows = "<S-Tab>",
      remove_file = "d",
      add_file = "@",
    },
        -- Customize key mappings as needed
      },
      -- Additional configuration options...
    },
    build = "make", -- Build the plugin
    dependencies = {
      "stevearc/dressing.nvim",
      "nvim-lua/plenary.nvim",
      "MunifTanjim/nui.nvim",
      -- Optional dependencies
      "hrsh7th/nvim-cmp", -- Autocompletion for avante commands and mentions
      "nvim-tree/nvim-web-devicons", -- File icons
      {
        "zbirenbaum/copilot.lua", -- GitHub Copilot integration
        config = function()
          require("copilot").setup({
            suggestion = { enabled = false },
            panel = { enabled = false },
          })
        end,
      },
    },
  },

{
  "linux-cultist/venv-selector.nvim",
    dependencies = {
      "neovim/nvim-lspconfig",
      "mfussenegger/nvim-dap", "mfussenegger/nvim-dap-python", --optional
      { "nvim-telescope/telescope.nvim", branch = "0.1.x", dependencies = { "nvim-lua/plenary.nvim" } },
    },
  lazy = false,
  branch = "regexp", -- This is the regexp branch, use this for the new version
  config = function()
      require("venv-selector").setup()
    end,
    keys = {
      { ",v", "<cmd>VenvSelect<cr>" },
    },
},
--
{'akinsho/git-conflict.nvim', version = "*", config = {
  default_mappings = true, -- disable buffer local mapping created by this plugin
  default_commands = true, -- disable commands created by this plugin
  disable_diagnostics = false, -- This will disable the diagnostics in a buffer whilst it is conflicted
  list_opener = 'copen', -- command or function to open the conflicts list
  highlights = { -- They must have background color, otherwise the default color will be used
    incoming = 'DiffAdd',
    current = 'DiffText',
  }
}
  }
}




local config = require("core.utils").load_config()

if #config.plugins > 0 then
  table.insert(default_plugins, { import = config.plugins })
end


local plugins = {
   -- Add lazygit.nvim and telescope.nvim with dependencies
   {
      "kdheepak/lazygit.nvim",
      dependencies = {
         "nvim-telescope/telescope.nvim",
         "nvim-lua/plenary.nvim"
      },
      config = function()
         require("telescope").load_extension("lazygit")
      end,
   },
}

-- vim.api.nvim_create_autocmd("BufEnter", {
--    callback = function()
--       require("lazygit.utils").project_root_dir()
--    end
-- })


require("lazy").setup(default_plugins, plugins, config.lazy_nvim)

require('refactoring').setup({})

-- require("lspconfig").azure_pipelines_ls.setup {
--   settings = {
--       yaml = {
--           schemas = {
--               ["https://raw.githubusercontent.com/microsoft/azure-pipelines-vscode/master/service-schema.json"] = {
--                   "/azure-pipeline*.y*l",
--                   "/*.azure*",
--                   "Azure-Pipelines/**/*.y*l",
--                   "Pipelines/*.y*l",
--               },
--           },
--       },
--   },
-- }
--

require("mason-lspconfig").setup {
    ensure_installed = { "lua_ls", "azure_pipelines_ls"},
}

require("lspconfig").azure_pipelines_ls.setup {
  settings = {
      yaml = {
          schemas = {
              ["https://raw.githubusercontent.com/microsoft/azure-pipelines-vscode/master/service-schema.json"] = {
                  "/azure-pipeline*.y*l",
                  "/*.azure*",
                  "Azure-Pipelines/**/*.y*l",
                  "Pipelines/*.y*l",
                  ".builds/*.y*l",
              },
          },
      },
  },
}

require'lspconfig'.yamlls.setup{}
require("venv-selector").workspace_paths()
require("venv-selector").file_dir()
require("venv-selector").cwd()
-- local notify = require("notify")
--
-- -- Set as default notification system
-- vim.notify = notify

