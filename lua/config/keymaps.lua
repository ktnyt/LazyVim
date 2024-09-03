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

-- aerial
vim.keymap.set("n", "<leader>a", "<cmd>AerialToggle!<CR>")

vim.keymap.set("n", "<leader>cyp", function()
  local buffer = vim.api.nvim_get_current_buf()
  local absolute_path = vim.api.nvim_buf_get_name(buffer)
  if string.sub(absolute_path, -3) ~= ".py" then
    -- return
  end
  local cwd_path = string.format("%s/", vim.loop.cwd())
  if cwd_path == nil then
    return
  end
  local relative_path = string.gsub(absolute_path, cwd_path, "")
  local python_path = string.gsub(relative_path, "/", ".")
  vim.fn.setreg("", python_path)
  vim.fn.setreg("*", python_path)
  vim.fn.setreg("+", python_path)
end, { desc = "Copy python path to current file" })
