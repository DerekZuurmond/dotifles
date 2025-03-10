vim.g.loaded_clipboard_provider = 0  -- Disable the default clipboard provider

require "core"

local custom_init_path = vim.api.nvim_get_runtime_file("lua/custom/init.lua", false)[1]

if custom_init_path then
  dofile(custom_init_path)
end

require("core.utils").load_mappings()

local lazypath = vim.fn.stdpath "data" .. "/lazy/lazy.nvim"

-- bootstrap lazy.nvim!
if not vim.loop.fs_stat(lazypath) then
  require("core.bootstrap").gen_chadrc_template()
  require("core.bootstrap").lazy(lazypath)
end

dofile(vim.g.base46_cache .. "defaults")
vim.opt.rtp:prepend(lazypath)
require "plugins"

-- Custom clipboard handling for WSL
local clip = "/mnt/c/Windows/System32/clip.exe"  -- Adjust this path if necessary
if vim.fn.executable(clip) == 1 then
    vim.api.nvim_create_augroup("WSLYank", { clear = true })
    vim.api.nvim_create_autocmd("TextYankPost", {
        group = "WSLYank",
        callback = function()
            if vim.v.event.operator == "y" then
                vim.fn.system(clip, vim.fn.getreg('"'))
            end
        end,
    })
end

vim.opt.relativenumber = true -- Show relative line numbersize
vim.opt.laststatus = 3 -- Always show status line
if vim.fn.has("termguicolors") == 1 then
  vim.opt.termguicolors = true
end

