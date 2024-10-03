-- Autocmds are automatically loaded on the VeryLazy event
-- Default autocmds that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/autocmds.lua
-- Add any additional autocmds here
vim.api.nvim_create_augroup("AutoDeleteNoNameBuffer", { clear = true })
vim.api.nvim_create_autocmd("BufEnter", {
  group = "AutoDeleteNoNameBuffer",
  pattern = "*",
  callback = function()
    local bufsize = #vim.fn.getbufinfo({ buflisted = 1 })
    if bufsize == 2 then
      for _, buf in pairs(vim.fn.getbufinfo({ buflisted = 1 })) do
        if buf.name == "" then
          vim.api.nvim_buf_delete(buf.bufnr, { force = true })
        end
      end
    end
  end,
})

-- Set GIT_EDITOR to use nvr if Neovim and nvr are available
if vim.fn.has("nvim") == 1 and vim.fn.executable("nvr") == 1 then
  vim.env.GIT_EDITOR = "nvr -cc split --remote-wait +'set bufhidden=wipe'"
end
