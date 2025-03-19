return {
  "mfussenegger/nvim-dap-python",
  ft = "python",
  dependencies = {
    "mfussenegger/nvim-dap",
    "rcarriga/nvim-dap-ui",
  },
  config = function(_, opts)
    local dap = require "dap"
    -- local dap_python = require "dap-python"

    local path = vim.fn.expand "~/.virtualenvs/debugpy/bin/python"
    require("dap-python").setup(path)

    dap.adapters.python = {
      type = "executable",
      command = path, -- Ensure this matches your debugpy environment
      args = { "-m", "debugpy.adapter" },
    }

    -- Define Default Debug Configurations
    dap.configurations.python = {
      {
        type = "python",
        request = "launch",
        name = "Launch File",
        program = "${file}", -- The current file being debugged
        console = "integratedTerminal",
        justMyCode = false,
        pythonPath = function()
          return path
        end,
      },
    }
  end,
}
