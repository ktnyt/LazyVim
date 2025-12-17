-- Options are automatically loaded before lazy.nvim startup
-- Default options that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/options.lua
-- Add any additional options here
vim.opt.scrolloff = 10

-- Enable project-specific .nvim.lua files
-- This allows .nvim.lua in project directories to be automatically loaded
-- Security note: Only enable this for trusted projects
vim.opt.exrc = true
vim.opt.secure = false -- Required for .nvim.lua to work (allows local config execution)
