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

---@param buffer integer
local function buf_get_rel_name(buffer)
  local absolute_path = vim.api.nvim_buf_get_name(buffer)
  local cwd_path = string.format("%s/", vim.loop.cwd())
  if cwd_path == nil then
    return nil
  end
  local relative_path = string.gsub(absolute_path, cwd_path, "")
  return relative_path
end

vim.keymap.set("n", "<leader>cyp", function()
  local buffer = vim.api.nvim_get_current_buf()
  local relative_path = buf_get_rel_name(buffer)
  if relative_path == nil then
    return
  end
  if string.sub(relative_path, -3) ~= ".py" then
    print(string.format("File does not seem to be Python: %s", relative_path))
    return
  end
  local python_path = string.gsub(relative_path, "/", ".")
  vim.fn.setreg("", python_path)
  vim.fn.setreg("*", python_path)
  vim.fn.setreg("+", python_path)
  print(string.format("Yanked Python path: %s", python_path))
end, { desc = "Yank python path to current file" })

local function get_remote_name()
  local cmd = "git remote"
  local openPop = assert(io.popen(cmd, "r"))
  for c in openPop:lines() do
    return c
  end
  return nil
end

---@param remote string
local function get_remote_url(remote)
  local cmd = string.format("git remote get-url '%s'", remote)
  local openPop = assert(io.popen(cmd, "r"))
  for c in openPop:lines() do
    return c
  end
  return nil
end

---@param arg string
local function get_user_repo(arg)
  local user_repo = arg
  user_repo = string.gsub(user_repo, "git@github.com:([-%w]+/[-%w_.]+).git$", "%1")
  user_repo = string.gsub(user_repo, "git@github.com:([-%w]+/[-%w_.]+)$", "%1")
  user_repo = string.gsub(user_repo, "https://github.com/([-%w]+/[-%w_.]+).git$", "%1")
  user_repo = string.gsub(user_repo, "https://github.com/([-%w]+/[-%w_.]+)$", "%1")
  if user_repo == arg then
    return nil
  end
  return user_repo
end

local function get_head_hash()
  local cmd = "git rev-parse HEAD"
  local openPop = assert(io.popen(cmd, "r"))
  for c in openPop:lines() do
    return c
  end
  return nil
end

vim.keymap.set("n", "<leader>cyg", function()
  local remote_name = get_remote_name()
  if remote_name == nil then
    print("No git remote detected")
    return
  end

  local remote_url = get_remote_url(remote_name)
  if remote_url == nil then
    print(string.format("Unable to retrieve remote url for: %s", remote_name))
    return
  end

  local user_repo = get_user_repo(remote_url)
  if user_repo == nil then
    print(string.format("Unable to retrieve user/repo url for: %s", remote_url))
    return
  end

  local head_hash = get_head_hash()
  if user_repo == nil then
    print("Unable to retrieve hash of HEAD")
    return
  end

  local buffer = vim.api.nvim_get_current_buf()
  local relative_path = buf_get_rel_name(buffer)
  if relative_path == nil then
    return
  end
  local permalink = string.format("https://github.com/%s/blob/%s/%s", user_repo, head_hash, relative_path)
  vim.fn.setreg("", permalink)
  vim.fn.setreg("*", permalink)
  vim.fn.setreg("+", permalink)
  print(string.format("Yanked GitHub permalink to HEAD: %s", permalink))
end, { desc = "Yank GitHub permalink to current file" })
