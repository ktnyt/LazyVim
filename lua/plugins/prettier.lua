return {
  -- Configure conform.nvim to use Prettier for Vue files (matching VSCode)
  {
    "stevearc/conform.nvim",
    opts = function(_, opts)
      -- Add Prettier formatter for Vue files to match VSCode
      opts.formatters_by_ft = opts.formatters_by_ft or {}
      opts.formatters_by_ft.vue = { "prettier" }
      
      -- Also add for TypeScript and JavaScript to match VSCode settings
      if not opts.formatters_by_ft.typescript then
        opts.formatters_by_ft.typescript = { "prettier" }
      end
      if not opts.formatters_by_ft.javascript then
        opts.formatters_by_ft.javascript = { "prettier" }
      end
      if not opts.formatters_by_ft.typescriptreact then
        opts.formatters_by_ft.typescriptreact = { "prettier" }
      end
      if not opts.formatters_by_ft.javascriptreact then
        opts.formatters_by_ft.javascriptreact = { "prettier" }
      end
      
      -- Ensure Prettier is configured
      opts.formatters = opts.formatters or {}
      opts.formatters.prettier = {
        -- Prettier will automatically find .prettierrc in the project root
        -- This matches VSCode's prettier-vscode behavior
        prepend_args = {},
      }
      
      return opts
    end,
  },
  
  -- Ensure Prettier is installed via Mason
  {
    "mason-org/mason.nvim",
    opts = function(_, opts)
      opts.ensure_installed = opts.ensure_installed or {}
      vim.list_extend(opts.ensure_installed, { "prettier" })
      return opts
    end,
  },
}
