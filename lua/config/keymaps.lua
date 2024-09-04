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

-- neovim 0.10 renames vim.loop to vim.uv
local uv = vim.uv or vim.loop

---@param buffer integer
local function buf_get_rel_name(buffer)
  local absolute_path = vim.api.nvim_buf_get_name(buffer)
  local cwd_path = string.format("%s/", uv.cwd())
  if cwd_path == nil then
    return nil
  end
  local relative_path = string.gsub(absolute_path, cwd_path, "")
  return relative_path
end

local function get_python_path()
  local buffer = vim.api.nvim_get_current_buf()
  local relative_path = buf_get_rel_name(buffer)
  if relative_path == nil then
    return
  end
  local basename = string.gsub(relative_path, ".py$", "")
  if basename == relative_path then
    print(string.format("File does not seem to be Python: %s", relative_path))
    return
  end
  local python_path = string.gsub(basename, "/", ".")
  vim.fn.setreg("+", python_path)
  print(string.format("Yanked Python path: %s", python_path))
end

vim.keymap.set("n", "<leader>cyp", get_python_path, { desc = "Yank python path to current file" })

vim.keymap.set("n", "<leader>cyg", "<cmd>RepoLink!<cr>", { desc = "Yank GitHub permalink to current file" })
