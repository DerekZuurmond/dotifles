local options = {
  ensure_installed = { "lua-language-server", "ruff", "black", "mypy", "azure-pipelines-ls", "sqlfluff", "yamlls",
    "pyright",
    "yamllint", "sqlfluff", "sqlls",
    "debugpy", "python-lps-server" },

  PATH = "skip",

  ui = {
    icons = {
      package_pending = " ",
      package_installed = "󰄳 ",
      package_uninstalled = " 󰚌",
    },

    keymaps = {
      toggle_server_expand = "<CR>",
      install_server = "i",
      update_server = "u",
      check_server_version = "c",
      update_all_servers = "U",
      check_outdated_servers = "C",
      uninstall_server = "X",
      cancel_installation = "<C-c>",
    },
  },

  max_concurrent_installers = 10,
}

return options
