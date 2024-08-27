return {
  "mbbill/undotree",

  config = function()
    vim.keymap.set("n", "<leader>uu", vim.cmd.UndotreeToggle, { desc = "Toggle Undotree" })
  end,
}
