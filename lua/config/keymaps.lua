-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here
vim.keymap.set("n", "<cr>", "o<C-[>")
vim.keymap.set("n", "<S-cr>", "<S-o><C-[>")

vim.keymap.set("n", "<C-u>", "<C-u>zz", { noremap = true })
vim.keymap.set("n", "<C-d>", "<C-d>zz", { noremap = true })

vim.keymap.set("n", "<C-f>", "<C-f>zz", { noremap = true })
vim.keymap.set("n", "<C-b>", "<C-b>zz", { noremap = true })

vim.keymap.set("n", "n", "nzz", { noremap = true })
vim.keymap.set("n", "N", "Nzz", { noremap = true })

vim.keymap.set("n", "<leader>fs", "<cmd>w<cr>", { desc = "Save file" })
vim.keymap.set("n", "<leader>qw", "<cmd>xa<cr>", { desc = "Save and quit" })

vim.keymap.set("i", "<space>", "<space><C-g>u")
vim.keymap.set("i", "<cr>", "<cr><C-g>u")
vim.keymap.set("i", "<tab>", "<tab><C-g>u")
